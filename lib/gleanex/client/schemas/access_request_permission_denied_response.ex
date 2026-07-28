defmodule Gleanex.Client.AccessRequestPermissionDeniedResponse do
  @moduledoc """
  Provides struct and type for a AccessRequestPermissionDeniedResponse
  """

  @type t :: %__MODULE__{
          createdBy: Gleanex.Client.Person.t(),
          errorType: String.t(),
          hasPendingRequest: boolean,
          requestableRoles: [String.t()]
        }

  defstruct [:createdBy, :errorType, :hasPendingRequest, :requestableRoles]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      createdBy: {Gleanex.Client.Person, :t},
      errorType: {:const, "PERMISSION_DENIED"},
      hasPendingRequest: :boolean,
      requestableRoles: [enum: ["OWNER", "VIEWER", "ANSWER_MODERATOR", "EDITOR", "VERIFIER"]]
    ]
  end
end
