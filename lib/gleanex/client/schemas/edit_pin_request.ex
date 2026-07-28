defmodule Gleanex.Client.EditPinRequest do
  @moduledoc """
  Provides struct and type for a EditPinRequest
  """

  @type t :: %__MODULE__{
          audienceFilters: [Gleanex.Client.FacetFilter.t()] | nil,
          id: String.t() | nil,
          queries: [String.t()] | nil
        }

  defstruct [:audienceFilters, :id, :queries]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [audienceFilters: [{Gleanex.Client.FacetFilter, :t}], id: :string, queries: [:string]]
  end
end
