defmodule Gleanex.Client.ServerToolRequest do
  @moduledoc """
  Provides struct and type for a ServerToolRequest
  """

  @type t :: %__MODULE__{
          actionPreview: Gleanex.Client.ActionPreview.t() | nil,
          requestId: String.t() | nil,
          requestType: String.t() | nil,
          serverId: String.t() | nil,
          toolCta: String.t() | nil,
          toolDisplayName: String.t() | nil
        }

  defstruct [:actionPreview, :requestId, :requestType, :serverId, :toolCta, :toolDisplayName]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      actionPreview: {Gleanex.Client.ActionPreview, :t},
      requestId: :string,
      requestType: {:enum, ["EXECUTION", "AUTHENTICATION_SUGGESTION", "VOTE_SUGGESTION"]},
      serverId: :string,
      toolCta: :string,
      toolDisplayName: :string
    ]
  end
end
