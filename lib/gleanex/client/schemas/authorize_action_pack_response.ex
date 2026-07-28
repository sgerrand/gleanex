defmodule Gleanex.Client.AuthorizeActionPackResponse do
  @moduledoc """
  Provides struct and type for a AuthorizeActionPackResponse
  """

  @type t :: %__MODULE__{redirectUrl: String.t()}

  defstruct [:redirectUrl]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [redirectUrl: :string]
  end
end
