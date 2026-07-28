defmodule Gleanex.Client.Disambiguation do
  @moduledoc """
  Provides struct and type for a Disambiguation
  """

  @type t :: %__MODULE__{id: String.t() | nil, name: String.t() | nil, type: String.t() | nil}

  defstruct [:id, :name, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [id: :string, name: :string, type: {:enum, ["PERSON", "PROJECT", "CUSTOMER"]}]
  end
end
