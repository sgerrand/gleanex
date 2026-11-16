defmodule Gleanex.Client.ServerToolResponse do
  @moduledoc """
  Provides struct and type for a ServerToolResponse
  """

  @type t :: %__MODULE__{
          authContext: Gleanex.Client.AuthContext.t() | nil,
          grantScope: String.t() | nil,
          isGranted: boolean | nil,
          requestId: String.t() | nil,
          requestType: String.t() | nil
        }

  defstruct [:authContext, :grantScope, :isGranted, :requestId, :requestType]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      authContext: {Gleanex.Client.AuthContext, :t},
      grantScope: {:enum, ["CURRENT_REQUEST", "CURRENT_SESSION", "ALWAYS"]},
      isGranted: :boolean,
      requestId: :string,
      requestType:
        {:enum, ["EXECUTION", "AUTHENTICATION_SUGGESTION", "VOTE_SUGGESTION", "SANDBOX_EGRESS"]}
    ]
  end
end
