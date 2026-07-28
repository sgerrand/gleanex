defmodule Gleanex.Client.PinRequest do
  @moduledoc """
  Provides struct and type for a PinRequest
  """

  @type t :: %__MODULE__{
          audienceFilters: [Gleanex.Client.FacetFilter.t()] | nil,
          documentId: String.t() | nil,
          queries: [String.t()] | nil
        }

  defstruct [:audienceFilters, :documentId, :queries]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [audienceFilters: [{Gleanex.Client.FacetFilter, :t}], documentId: :string, queries: [:string]]
  end
end
