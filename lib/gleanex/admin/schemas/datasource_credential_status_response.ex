defmodule Gleanex.Admin.DatasourceCredentialStatusResponse do
  @moduledoc """
  Provides struct and type for a DatasourceCredentialStatusResponse
  """

  @type t :: %__MODULE__{
          expiresAt: DateTime.t() | nil,
          lastRotatedAt: DateTime.t() | nil,
          message: String.t() | nil,
          status: String.t()
        }

  defstruct [:expiresAt, :lastRotatedAt, :message, :status]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      expiresAt: {:string, "date-time"},
      lastRotatedAt: {:string, "date-time"},
      message: :string,
      status: {:enum, ["VALID", "VALID_WITH_WARNINGS", "VALIDATING", "INVALID", "MISSING"]}
    ]
  end
end
