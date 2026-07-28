defmodule Gleanex.Client.FacetBucket do
  @moduledoc """
  Provides struct and type for a FacetBucket
  """

  @type t :: %__MODULE__{
          count: integer | nil,
          datasource: String.t() | nil,
          percentage: integer | nil,
          value: Gleanex.Client.FacetValue.t() | nil
        }

  defstruct [:count, :datasource, :percentage, :value]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      count: :integer,
      datasource: :string,
      percentage: :integer,
      value: {Gleanex.Client.FacetValue, :t}
    ]
  end
end
