defmodule Gleanex.Client.Activity do
  @moduledoc """
  Provides API endpoints related to activity
  """

  @default_client Gleanex.HTTP

  @doc """
  Report document activity

  Report user activity that occurs on indexed documents such as viewing or editing. This signal improves search quality.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec activity(body :: map, opts :: keyword) :: :ok | {:error, Gleanex.Error.t()}
  def activity(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Client.Activity, :activity},
      url: "/activity",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, :null}, {400, :null}, {401, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Report client activity

  Report events that happen to results within a Glean client UI, such as search result views and clicks.  This signal improves search quality.

  ## Options

    * `feedback`: A URL encoded versions of Feedback. This is useful for requests.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec feedback(body :: Gleanex.Client.Feedback.t(), opts :: keyword) ::
          :ok | {:error, Gleanex.Error.t()}
  def feedback(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:feedback])

    client.request(%{
      args: [body: body],
      call: {Gleanex.Client.Activity, :feedback},
      url: "/feedback",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Gleanex.Client.Feedback, :t}}],
      response: [{200, :null}, {400, :null}, {401, :null}, {429, :null}],
      opts: opts
    })
  end

  @type t :: %__MODULE__{events: [Gleanex.Client.ActivityEvent.t()]}

  defstruct [:events]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [events: [{Gleanex.Client.ActivityEvent, :t}]]
  end
end
