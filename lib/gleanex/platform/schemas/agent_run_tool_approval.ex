defmodule Gleanex.Platform.AgentRunToolApproval do
  @moduledoc """
  Provides struct and type for a AgentRunToolApproval
  """

  @type t :: %__MODULE__{
          arguments: map,
          description: String.t(),
          display_name: String.t(),
          expires_at: DateTime.t() | nil,
          interaction_id: String.t(),
          tool_id: String.t() | nil,
          type: String.t()
        }

  defstruct [
    :arguments,
    :description,
    :display_name,
    :expires_at,
    :interaction_id,
    :tool_id,
    :type
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      arguments: :map,
      description: :string,
      display_name: :string,
      expires_at: {:string, "date-time"},
      interaction_id: :string,
      tool_id: :string,
      type: {:const, "TOOL_APPROVAL"}
    ]
  end
end
