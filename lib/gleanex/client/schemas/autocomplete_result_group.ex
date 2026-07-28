defmodule Gleanex.Client.AutocompleteResultGroup do
  @moduledoc """
  Provides struct and type for a AutocompleteResultGroup
  """

  @type t :: %__MODULE__{
          endIndex: integer | nil,
          startIndex: integer | nil,
          title: String.t() | nil
        }

  defstruct [:endIndex, :startIndex, :title]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [endIndex: :integer, startIndex: :integer, title: :string]
  end
end
