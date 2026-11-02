defmodule Gleanex.Platform.Triggers do
  @moduledoc """
  Provides API endpoints related to triggers
  """

  @default_client Gleanex.HTTP

  @doc """
  Create trigger

  Create a trigger from a preset and return it with its signing secret.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec create(body :: Gleanex.Platform.TriggerCreateRequest.t(), opts :: keyword) ::
          {:ok, Gleanex.Platform.TriggerCreateResponse.t()} | {:error, Gleanex.Error.t()}
  def create(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Platform.Triggers, :create},
      url: "/triggers",
      body: body,
      method: :post,
      request: [{"application/json", {Gleanex.Platform.TriggerCreateRequest, :t}}],
      response: [
        {201, {Gleanex.Platform.TriggerCreateResponse, :t}},
        {400, {Gleanex.Platform.ProblemDetail, :t}},
        {401, {Gleanex.Platform.ProblemDetail, :t}},
        {403, {Gleanex.Platform.ProblemDetail, :t}},
        {404, {Gleanex.Platform.ProblemDetail, :t}},
        {408, {Gleanex.Platform.ProblemDetail, :t}},
        {409, {Gleanex.Platform.ProblemDetail, :t}},
        {413, {Gleanex.Platform.ProblemDetail, :t}},
        {429, {Gleanex.Platform.ProblemDetail, :t}},
        {500, {Gleanex.Platform.ProblemDetail, :t}},
        {503, {Gleanex.Platform.ProblemDetail, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Delete trigger

  Delete a trigger.

  """
  @spec delete(trigger_id :: String.t(), opts :: keyword) :: :ok | {:error, Gleanex.Error.t()}
  def delete(trigger_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [trigger_id: trigger_id],
      call: {Gleanex.Platform.Triggers, :delete},
      url: "/triggers/#{trigger_id}",
      method: :delete,
      response: [
        {204, :null},
        {400, {Gleanex.Platform.ProblemDetail, :t}},
        {401, {Gleanex.Platform.ProblemDetail, :t}},
        {403, {Gleanex.Platform.ProblemDetail, :t}},
        {404, {Gleanex.Platform.ProblemDetail, :t}},
        {408, {Gleanex.Platform.ProblemDetail, :t}},
        {429, {Gleanex.Platform.ProblemDetail, :t}},
        {500, {Gleanex.Platform.ProblemDetail, :t}},
        {503, {Gleanex.Platform.ProblemDetail, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Search events for a trigger

  Search recent content events an existing trigger matches. Read-only — no webhook delivery is made. Covers the last seven days.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec events_search(
          trigger_id :: String.t(),
          body :: Gleanex.Platform.TriggerEventSearchRequest.t(),
          opts :: keyword
        ) :: {:ok, Gleanex.Platform.TriggerEventSearchResponse.t()} | {:error, Gleanex.Error.t()}
  def events_search(trigger_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [trigger_id: trigger_id, body: body],
      call: {Gleanex.Platform.Triggers, :events_search},
      url: "/triggers/#{trigger_id}/events/search",
      body: body,
      method: :post,
      request: [{"application/json", {Gleanex.Platform.TriggerEventSearchRequest, :t}}],
      response: [
        {200, {Gleanex.Platform.TriggerEventSearchResponse, :t}},
        {400, {Gleanex.Platform.ProblemDetail, :t}},
        {401, {Gleanex.Platform.ProblemDetail, :t}},
        {403, {Gleanex.Platform.ProblemDetail, :t}},
        {404, {Gleanex.Platform.ProblemDetail, :t}},
        {408, {Gleanex.Platform.ProblemDetail, :t}},
        {413, {Gleanex.Platform.ProblemDetail, :t}},
        {429, {Gleanex.Platform.ProblemDetail, :t}},
        {500, {Gleanex.Platform.ProblemDetail, :t}},
        {503, {Gleanex.Platform.ProblemDetail, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get trigger

  Retrieve a trigger owned by the authenticated caller.

  """
  @spec get(trigger_id :: String.t(), opts :: keyword) ::
          {:ok, Gleanex.Platform.TriggerGetResponse.t()} | {:error, Gleanex.Error.t()}
  def get(trigger_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [trigger_id: trigger_id],
      call: {Gleanex.Platform.Triggers, :get},
      url: "/triggers/#{trigger_id}",
      method: :get,
      response: [
        {200, {Gleanex.Platform.TriggerGetResponse, :t}},
        {400, {Gleanex.Platform.ProblemDetail, :t}},
        {401, {Gleanex.Platform.ProblemDetail, :t}},
        {403, {Gleanex.Platform.ProblemDetail, :t}},
        {404, {Gleanex.Platform.ProblemDetail, :t}},
        {408, {Gleanex.Platform.ProblemDetail, :t}},
        {429, {Gleanex.Platform.ProblemDetail, :t}},
        {500, {Gleanex.Platform.ProblemDetail, :t}},
        {503, {Gleanex.Platform.ProblemDetail, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List triggers

  List triggers owned by the authenticated caller.

  ## Options

    * `page_size`: Maximum number of triggers to return.
    * `cursor`: Opaque pagination cursor from a previous response.

  """
  @spec list(opts :: keyword) ::
          {:ok, Gleanex.Platform.TriggerListResponse.t()} | {:error, Gleanex.Error.t()}
  def list(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:cursor, :page_size])

    client.request(%{
      args: [],
      call: {Gleanex.Platform.Triggers, :list},
      url: "/triggers",
      method: :get,
      query: query,
      response: [
        {200, {Gleanex.Platform.TriggerListResponse, :t}},
        {400, {Gleanex.Platform.ProblemDetail, :t}},
        {401, {Gleanex.Platform.ProblemDetail, :t}},
        {403, {Gleanex.Platform.ProblemDetail, :t}},
        {408, {Gleanex.Platform.ProblemDetail, :t}},
        {429, {Gleanex.Platform.ProblemDetail, :t}},
        {500, {Gleanex.Platform.ProblemDetail, :t}},
        {503, {Gleanex.Platform.ProblemDetail, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Search events for a trigger preset

  Search recent content events an unsaved trigger built from this preset would match, to preview it before creating the trigger. Read-only — no trigger is created and no webhook delivery is made. Covers the last seven days.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec trigger_presets_events_search(
          preset_id :: String.t(),
          body :: Gleanex.Platform.TriggerPresetEventSearchRequest.t(),
          opts :: keyword
        ) :: {:ok, Gleanex.Platform.TriggerEventSearchResponse.t()} | {:error, Gleanex.Error.t()}
  def trigger_presets_events_search(preset_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [preset_id: preset_id, body: body],
      call: {Gleanex.Platform.Triggers, :trigger_presets_events_search},
      url: "/trigger-presets/#{preset_id}/events/search",
      body: body,
      method: :post,
      request: [{"application/json", {Gleanex.Platform.TriggerPresetEventSearchRequest, :t}}],
      response: [
        {200, {Gleanex.Platform.TriggerEventSearchResponse, :t}},
        {400, {Gleanex.Platform.ProblemDetail, :t}},
        {401, {Gleanex.Platform.ProblemDetail, :t}},
        {403, {Gleanex.Platform.ProblemDetail, :t}},
        {404, {Gleanex.Platform.ProblemDetail, :t}},
        {408, {Gleanex.Platform.ProblemDetail, :t}},
        {413, {Gleanex.Platform.ProblemDetail, :t}},
        {429, {Gleanex.Platform.ProblemDetail, :t}},
        {500, {Gleanex.Platform.ProblemDetail, :t}},
        {503, {Gleanex.Platform.ProblemDetail, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get trigger preset

  Retrieve a single trigger preset by id.

  """
  @spec trigger_presets_get(preset_id :: String.t(), opts :: keyword) ::
          {:ok, Gleanex.Platform.TriggerPresetGetResponse.t()} | {:error, Gleanex.Error.t()}
  def trigger_presets_get(preset_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [preset_id: preset_id],
      call: {Gleanex.Platform.Triggers, :trigger_presets_get},
      url: "/trigger-presets/#{preset_id}",
      method: :get,
      response: [
        {200, {Gleanex.Platform.TriggerPresetGetResponse, :t}},
        {400, {Gleanex.Platform.ProblemDetail, :t}},
        {401, {Gleanex.Platform.ProblemDetail, :t}},
        {403, {Gleanex.Platform.ProblemDetail, :t}},
        {404, {Gleanex.Platform.ProblemDetail, :t}},
        {408, {Gleanex.Platform.ProblemDetail, :t}},
        {429, {Gleanex.Platform.ProblemDetail, :t}},
        {500, {Gleanex.Platform.ProblemDetail, :t}},
        {503, {Gleanex.Platform.ProblemDetail, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Search trigger preset input values

  Return up to 300 selectable values for a single picklist input on a preset. Results are intended for typeahead selection and are not cursor-paginated. When `is_truncated` is true, refine `query` to narrow the result set.

  ## Options

    * `field`: Field identifier of the input whose values to list.
    * `query`: Prefix filter over the input's option values, for typeahead. Matching is on the option value, not its display name.
      

  """
  @spec trigger_presets_input_values_list(preset_id :: String.t(), opts :: keyword) ::
          {:ok, Gleanex.Platform.TriggerPresetInputValueListResponse.t()}
          | {:error, Gleanex.Error.t()}
  def trigger_presets_input_values_list(preset_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:field, :query])

    client.request(%{
      args: [preset_id: preset_id],
      call: {Gleanex.Platform.Triggers, :trigger_presets_input_values_list},
      url: "/trigger-presets/#{preset_id}/input-values",
      method: :get,
      query: query,
      response: [
        {200, {Gleanex.Platform.TriggerPresetInputValueListResponse, :t}},
        {400, {Gleanex.Platform.ProblemDetail, :t}},
        {401, {Gleanex.Platform.ProblemDetail, :t}},
        {403, {Gleanex.Platform.ProblemDetail, :t}},
        {404, {Gleanex.Platform.ProblemDetail, :t}},
        {408, {Gleanex.Platform.ProblemDetail, :t}},
        {429, {Gleanex.Platform.ProblemDetail, :t}},
        {500, {Gleanex.Platform.ProblemDetail, :t}},
        {503, {Gleanex.Platform.ProblemDetail, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List trigger presets

  List the trigger presets available to the caller. A preset is a curated content-trigger template (e.g. a new Jira ticket) which is passed when creating a trigger.

  ## Options

    * `datasource`: Restrict results to presets for a single datasource (e.g. github).
    * `page_size`: Maximum number of presets to return.
    * `cursor`: Opaque pagination cursor from a previous response.

  """
  @spec trigger_presets_list(opts :: keyword) ::
          {:ok, Gleanex.Platform.TriggerPresetListResponse.t()} | {:error, Gleanex.Error.t()}
  def trigger_presets_list(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:cursor, :datasource, :page_size])

    client.request(%{
      args: [],
      call: {Gleanex.Platform.Triggers, :trigger_presets_list},
      url: "/trigger-presets",
      method: :get,
      query: query,
      response: [
        {200, {Gleanex.Platform.TriggerPresetListResponse, :t}},
        {400, {Gleanex.Platform.ProblemDetail, :t}},
        {401, {Gleanex.Platform.ProblemDetail, :t}},
        {403, {Gleanex.Platform.ProblemDetail, :t}},
        {408, {Gleanex.Platform.ProblemDetail, :t}},
        {429, {Gleanex.Platform.ProblemDetail, :t}},
        {500, {Gleanex.Platform.ProblemDetail, :t}},
        {503, {Gleanex.Platform.ProblemDetail, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Update trigger

  Update a trigger.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec update(
          trigger_id :: String.t(),
          body :: Gleanex.Platform.TriggerUpdateRequest.t(),
          opts :: keyword
        ) :: {:ok, Gleanex.Platform.TriggerGetResponse.t()} | {:error, Gleanex.Error.t()}
  def update(trigger_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [trigger_id: trigger_id, body: body],
      call: {Gleanex.Platform.Triggers, :update},
      url: "/triggers/#{trigger_id}",
      body: body,
      method: :patch,
      request: [{"application/json", {Gleanex.Platform.TriggerUpdateRequest, :t}}],
      response: [
        {200, {Gleanex.Platform.TriggerGetResponse, :t}},
        {400, {Gleanex.Platform.ProblemDetail, :t}},
        {401, {Gleanex.Platform.ProblemDetail, :t}},
        {403, {Gleanex.Platform.ProblemDetail, :t}},
        {404, {Gleanex.Platform.ProblemDetail, :t}},
        {408, {Gleanex.Platform.ProblemDetail, :t}},
        {413, {Gleanex.Platform.ProblemDetail, :t}},
        {429, {Gleanex.Platform.ProblemDetail, :t}},
        {500, {Gleanex.Platform.ProblemDetail, :t}},
        {503, {Gleanex.Platform.ProblemDetail, :t}}
      ],
      opts: opts
    })
  end
end
