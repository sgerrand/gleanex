defmodule Gleanex.Indexing.TeamEmail do
  @moduledoc """
  Provides struct and type for a TeamEmail
  """

  @type t :: %__MODULE__{email: String.t(), type: String.t()}

  defstruct [:email, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [email: {:string, "email"}, type: :string]
  end
end
