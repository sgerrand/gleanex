defmodule Gleanex.Client.FacetResult do
  @moduledoc """
  Provides struct and type for a FacetResult
  """

  @type t :: %__MODULE__{
          buckets: [Gleanex.Client.FacetBucket.t()] | nil,
          groupName: String.t() | nil,
          hasMoreBuckets: boolean | nil,
          operatorName: String.t() | nil,
          sourceName: String.t() | nil
        }

  defstruct [:buckets, :groupName, :hasMoreBuckets, :operatorName, :sourceName]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      buckets: [{Gleanex.Client.FacetBucket, :t}],
      groupName: :string,
      hasMoreBuckets: :boolean,
      operatorName: :string,
      sourceName: :string
    ]
  end
end
