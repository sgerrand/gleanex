defmodule Gleanex.Client.FacetBucketFilter do
  @moduledoc """
  Provides struct and type for a FacetBucketFilter
  """

  @type t :: %__MODULE__{facet: String.t() | nil, prefix: String.t() | nil}

  defstruct [:facet, :prefix]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [facet: :string, prefix: :string]
  end
end
