defmodule Gleanex.Client.InvalidOperatorValueError do
  @moduledoc """
  Provides struct and type for a InvalidOperatorValueError
  """

  @type t :: %__MODULE__{key: String.t() | nil, value: String.t() | nil}

  defstruct [:key, :value]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [key: :string, value: :string]
  end
end
