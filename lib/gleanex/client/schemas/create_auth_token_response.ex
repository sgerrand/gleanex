defmodule Gleanex.Client.CreateAuthTokenResponse do
  @moduledoc """
  Provides struct and type for a CreateAuthTokenResponse
  """

  @type t :: %__MODULE__{expirationTime: integer, token: String.t()}

  defstruct [:expirationTime, :token]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [expirationTime: {:integer, "int64"}, token: :string]
  end
end
