defmodule Gleanex.Client.ActionPackAuthStatus do
  @moduledoc """
  Provides struct and type for a ActionPackAuthStatus
  """

  @type t :: %__MODULE__{authType: String.t(), authenticated: boolean}

  defstruct [:authType, :authenticated]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [authType: {:enum, ["AUTH_USER_OAUTH", "AUTH_ADMIN", "AUTH_NONE"]}, authenticated: :boolean]
  end
end
