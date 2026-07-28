defmodule Gleanex.Client.FeedResponse do
  @moduledoc """
  Provides struct and type for a FeedResponse
  """

  @type t :: %__MODULE__{
          experimentIds: [integer] | nil,
          facetResults: map | nil,
          mentionsTimeWindowInHours: integer | nil,
          results: [Gleanex.Client.FeedResult.t()] | nil,
          serverTimestamp: integer,
          trackingToken: String.t() | nil
        }

  defstruct [
    :experimentIds,
    :facetResults,
    :mentionsTimeWindowInHours,
    :results,
    :serverTimestamp,
    :trackingToken
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      experimentIds: [integer: "int64"],
      facetResults: :map,
      mentionsTimeWindowInHours: :integer,
      results: [{Gleanex.Client.FeedResult, :t}],
      serverTimestamp: :integer,
      trackingToken: :string
    ]
  end
end
