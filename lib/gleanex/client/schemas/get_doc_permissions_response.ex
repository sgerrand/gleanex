defmodule Gleanex.Client.GetDocPermissionsResponse do
  @moduledoc """
  Provides struct and type for a GetDocPermissionsResponse
  """

  @type t :: %__MODULE__{allowedUserEmails: [String.t()] | nil}

  defstruct [:allowedUserEmails]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [allowedUserEmails: [:string]]
  end
end
