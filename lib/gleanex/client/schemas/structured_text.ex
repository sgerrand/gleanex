defmodule Gleanex.Client.StructuredText do
  @moduledoc """
  Provides struct and type for a StructuredText
  """

  @type t :: %__MODULE__{
          structuredList: [Gleanex.Client.StructuredTextItem.t()] | nil,
          text: String.t() | nil
        }

  defstruct [:structuredList, :text]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [structuredList: [{Gleanex.Client.StructuredTextItem, :t}], text: :string]
  end
end
