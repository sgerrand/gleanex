defmodule Gleanex.Platform.AgentSchemasResponse do
  @moduledoc """
  Provides struct and type for a AgentSchemasResponse
  """

  @type t :: %__MODULE__{
          agent_id: String.t(),
          input_schema: map,
          name: String.t() | nil,
          output_schema: map,
          request_id: String.t(),
          tools: [Gleanex.Platform.ActionSummary.t()] | nil
        }

  defstruct [:agent_id, :input_schema, :name, :output_schema, :request_id, :tools]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      agent_id: :string,
      input_schema: :map,
      name: :string,
      output_schema: :map,
      request_id: :string,
      tools: [{Gleanex.Platform.ActionSummary, :t}]
    ]
  end
end
