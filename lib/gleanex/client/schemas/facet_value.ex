defmodule Gleanex.Client.FacetValue do
  @moduledoc """
  Provides struct and type for a FacetValue
  """

  @type t :: %__MODULE__{
          displayLabel: String.t() | nil,
          iconConfig: Gleanex.Client.IconConfig.t() | nil,
          integerValue: integer | nil,
          stringValue: String.t() | nil
        }

  defstruct [:displayLabel, :iconConfig, :integerValue, :stringValue]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      displayLabel: :string,
      iconConfig: {Gleanex.Client.IconConfig, :t},
      integerValue: :integer,
      stringValue: :string
    ]
  end
end
