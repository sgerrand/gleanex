defmodule Gleanex.Client.FacetFilter do
  @moduledoc """
  Provides struct and type for a FacetFilter
  """

  @type t :: %__MODULE__{
          fieldName: String.t() | nil,
          groupName: String.t() | nil,
          values: [Gleanex.Client.FacetFilterValue.t()] | nil
        }

  defstruct [:fieldName, :groupName, :values]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [fieldName: :string, groupName: :string, values: [{Gleanex.Client.FacetFilterValue, :t}]]
  end
end
