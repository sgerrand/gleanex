defmodule Gleanex.GeneratedSweepTest do
  @moduledoc """
  Executes every generated function at least once.

  Compiling proves the generated code parses and typechecks; it does not prove
  it runs. These sweeps call each operation against a stub and read every
  schema's field table, so a generator or transport change that breaks one
  corner of the surface fails here rather than in a caller's application.

  Deliberately shallow. Asserting anything specific about 149 operations would
  mean restating the descriptions in test code, and every regeneration would
  churn it. What is asserted is what applies uniformly: the call reaches the
  transport, the right URL and verb come out, and the response decodes.
  """

  # Not async: generated operations that take only opts are also exported at
  # arity zero, and the only way to reach that clause is to call it with no
  # config at all. That falls back to Gleanex.Config.default/0, which reads the
  # application environment, so the environment has to be set here and it is
  # global.
  use ExUnit.Case, async: false

  @generated_namespaces ~w(Client Indexing Platform Admin)

  setup context do
    Req.Test.set_req_test_from_context(context)

    base = [token: "secret", domain: "acme", req_options: [plug: {Req.Test, GleanexSweepStub}]]

    previous = Enum.map([:domain, :token, :req_options], &{&1, Application.get_env(:gleanex, &1)})
    Enum.each(base, fn {key, value} -> Application.put_env(:gleanex, key, value) end)

    on_exit(fn ->
      Enum.each(previous, fn
        {key, nil} -> Application.delete_env(:gleanex, key)
        {key, value} -> Application.put_env(:gleanex, key, value)
      end)
    end)

    %{
      client: Gleanex.new(base),
      indexing: Gleanex.new([{:scope, :indexing} | base])
    }
  end

  describe "schemas" do
    test "every generated schema exposes a usable field table" do
      schemas = generated_modules() |> Enum.filter(&exports?(&1, :__fields__, 1))

      # Guards against the sweep silently covering nothing if the naming or
      # layout of generated modules changes.
      assert length(schemas) > 400,
             "expected the bulk of the generated tree, got #{length(schemas)}"

      for module <- schemas do
        types = field_types(module)

        assert types != [], "#{inspect(module)} has no schema type to read fields for"

        for type <- types do
          fields = module.__fields__(type)

          assert Keyword.keyword?(fields),
                 "#{inspect(module)}.__fields__(#{inspect(type)}) returned #{inspect(fields)}"

          for {name, field_type} <- fields do
            assert is_atom(name)
            refute is_nil(field_type), "#{inspect(module)} field #{name} has no type"
          end
        end

        # The zero-arity head exists only for modules whose schema is named :t.
        if :t in types, do: assert(module.__fields__() == module.__fields__(:t))
      end
    end

    test "every schema struct has a key for each of its fields" do
      for module <- generated_modules(),
          exports?(module, :__fields__, 0),
          exports?(module, :__struct__, 0) do
        keys = module.__struct__() |> Map.from_struct() |> Map.keys() |> MapSet.new()

        for {name, _type} <- module.__fields__() do
          assert MapSet.member?(keys, name),
                 "#{inspect(module)} declares field #{name} with no matching struct key"
        end
      end
    end
  end

  describe "operations" do
    test "every generated operation reaches the transport and decodes a response", context do
      Req.Test.stub(GleanexSweepStub, fn conn ->
        # Every operation should resolve to its API's prefix and nothing else.
        assert conn.request_path =~ ~r{^/(rest/api/v1|api/index/v1|api)/},
               "unexpected path #{conn.request_path}"

        assert Plug.Conn.get_req_header(conn, "authorization") == ["Bearer secret"]

        Req.Test.json(conn, %{})
      end)

      operations = all_operations()

      assert length(operations) > 140,
             "expected the full operation surface, got #{length(operations)}"

      failures =
        for {module, function, arity} <- operations,
            result = call(module, function, arity, context),
            match?({:failed, _}, result) do
          {:failed, reason} = result
          "#{inspect(module)}.#{function}/#{arity}: #{reason}"
        end

      assert failures == [],
             "#{length(failures)} generated operation(s) did not complete:\n" <>
               Enum.join(Enum.take(failures, 20), "\n")
    end

    test "operations surface transport failures rather than raising", context do
      Req.Test.stub(GleanexSweepStub, fn conn ->
        conn |> Plug.Conn.put_status(500) |> Req.Test.json(%{title: "Boom"})
      end)

      # One operation per API is enough: the failure path is in the shared
      # transport, not in the generated code.
      for {module, function, arity} <- Enum.map(@generated_namespaces, &first_operation/1) do
        assert {:error, %Gleanex.Error{status: 500}} =
                 call(module, function, arity, context, retry: Gleanex.Retry.disabled())
      end
    end
  end

  defp call(module, function, arity, context, extra_opts \\ []) do
    args = arguments(module, function, arity, context, extra_opts)

    case attempt(module, function, args) do
      {:failed, _reason} when arity > 0 ->
        # The file upload endpoints send their body as multipart, which has to
        # be enumerable rather than a string. The body is the last positional
        # argument, so only that one changes.
        attempt(module, function, replace_body(args, %{file: "contents"}))

      result ->
        result
    end
  end

  # Positional arguments are path parameters followed by a request body. A
  # string serves for both: it interpolates into a URL and encodes as JSON.
  #
  # Only the widest arity has an opts slot to carry the config. The narrower
  # arities are the ones `opts \\ []` generates, and they fall back to the
  # application environment set in setup.
  defp arguments(module, function, arity, context, extra_opts) do
    if arity == max_arity(module, function) and arity > 0 do
      config = if api_of(module) == :indexing, do: context.indexing, else: context.client
      List.duplicate("x", arity - 1) ++ [Keyword.merge([config: config], extra_opts)]
    else
      List.duplicate("x", arity)
    end
  end

  defp replace_body(args, body) do
    {leading, [_body | rest]} = Enum.split(args, length(args) - trailing_count(args) - 1)
    leading ++ [body | rest]
  end

  # The opts keyword, when present, always sits last.
  defp trailing_count(args), do: if(Keyword.keyword?(List.last(args)), do: 1, else: 0)

  defp max_arity(module, function) do
    module.__info__(:functions)
    |> Enum.filter(fn {name, _arity} -> name == function end)
    |> Enum.map(&elem(&1, 1))
    |> Enum.max()
  end

  defp attempt(module, function, args) do
    apply(module, function, args)
  rescue
    error -> {:failed, Exception.message(error)}
  catch
    :exit, reason -> {:failed, "exited: #{inspect(reason)}"}
  end

  # Schema type names come from the module's typespecs, because operation
  # modules holding an inline schema name it after the operation rather than :t.
  defp field_types(module) do
    case Code.Typespec.fetch_types(module) do
      {:ok, types} -> for {:type, {name, _definition, _args}} <- types, do: name
      :error -> []
    end
  end

  # The widest arity, so there is an opts slot to disable retries through.
  defp first_operation(namespace) do
    all_operations()
    |> Enum.filter(fn {module, function, arity} ->
      module |> Module.split() |> Enum.at(1) == namespace and
        arity == max_arity(module, function) and arity > 0
    end)
    |> Enum.sort()
    |> List.first()
  end

  # Every arity, not just the widest. Generated operations end in `opts \\ []`,
  # and the narrower arity that default produces is a distinct function: calling
  # only the wide one leaves the `def` line unexecuted.
  defp all_operations do
    for module <- generated_modules(),
        {function, arity} <- module.__info__(:functions),
        function not in [:__fields__, :__struct__] do
      {module, function, arity}
    end
  end

  defp generated_modules do
    {:ok, modules} = :application.get_key(:gleanex, :modules)

    Enum.filter(modules, fn module ->
      case Module.split(module) do
        ["Gleanex", namespace | rest] ->
          namespace in @generated_namespaces and not Enum.any?(rest, &(&1 =~ "Support"))

        _ ->
          false
      end
    end)
  end

  defp api_of(module) do
    module |> Module.split() |> Enum.at(1) |> String.downcase() |> String.to_existing_atom()
  end

  defp exports?(module, function, arity) do
    Code.ensure_loaded?(module) and function_exported?(module, function, arity)
  end
end
