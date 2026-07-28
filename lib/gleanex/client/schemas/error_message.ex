defmodule Gleanex.Client.ErrorMessage do
  @moduledoc """
  Provides struct and type for a ErrorMessage
  """

  @type t :: %__MODULE__{errorMessage: String.t() | nil, source: String.t() | nil}

  defstruct [:errorMessage, :source]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [errorMessage: :string, source: :string]
  end
end
