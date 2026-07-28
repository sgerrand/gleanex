defmodule Gleanex.Generator.Processor do
  @moduledoc """
  Code generation plugin that fixes up operation function names.

  This module is only compiled in the `:dev` environment and is not shipped in
  the package. It exists because Glean's four descriptions each name operations
  a different way, and the generator's defaults carry that inconsistency
  straight into the public API.

  Two rules, both purely mechanical:

  ## Drop prefixes the module already says

  Platform operation IDs repeat the API and the tag: `platform-agents-get-schemas`
  under tag `Agents` would become a function named `platform_agents_get_schemas`
  on `Gleanex.Platform.Agents`. Leading tokens matching the profile name or a tag
  are dropped, giving `get_schemas` instead.

  Only whole tokens are matched, and stripping never empties the name, so
  `platform-agents-search` keeps its last word as `search/2` and `createAgent`
  under tag `Agents` stays `create_agent/2` because `agent` is not `agents`.

  ## Name Indexing operations after their path

  The Indexing description has no operation IDs at all, so the default falls
  back to path plus method: `indexdocument_post`. The method suffix is dropped
  for `POST` only, which is the verb Indexing uses for every write. Paths that
  carry more than one method use `GET`, `PUT` and `DELETE`, so those keep their
  suffix and no two operations in a module can collide.

  Glean's own run-together words (`indexdocument`, `createannouncement`) are
  left alone. Splitting them would need a hand-maintained vocabulary, and an
  unrecognised new word would silently rename a public function.
  """

  use OpenAPI.Processor

  alias OpenAPI.Processor.Naming
  alias OpenAPI.Spec.Path.Operation, as: OperationSpec

  @impl OpenAPI.Processor
  def operation_function_name(state, %OperationSpec{operation_id: id} = spec)
      when is_binary(id) and id != "" do
    id
    |> String.split("/", trim: true)
    |> List.last()
    |> tokenize()
    |> drop_prefix([to_string(state.profile)])
    |> drop_tags(spec.tags)
    |> join()
  end

  def operation_function_name(_state, spec) do
    %OperationSpec{"$oag_path": path, "$oag_path_method": method} = spec

    case to_string(method) |> String.downcase() do
      "post" -> path |> tokenize() |> join()
      other -> "#{path}_#{other}" |> tokenize() |> join()
    end
  end

  defp tokenize(string) do
    string
    |> Naming.normalize_identifier()
    |> String.split("_", trim: true)
  end

  defp join(tokens), do: tokens |> Enum.join("_") |> String.to_atom()

  defp drop_tags(tokens, tags) when is_list(tags) do
    Enum.reduce(tags, tokens, fn tag, acc -> drop_prefix(acc, tokenize(tag)) end)
  end

  defp drop_tags(tokens, _tags), do: tokens

  # Never strips the name down to nothing: an operation named only after its tag
  # keeps that word as its function name.
  defp drop_prefix(tokens, prefix) do
    if length(tokens) > length(prefix) and List.starts_with?(tokens, prefix) do
      Enum.drop(tokens, length(prefix))
    else
      tokens
    end
  end
end
