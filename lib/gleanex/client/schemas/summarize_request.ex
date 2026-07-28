defmodule Gleanex.Client.SummarizeRequest do
  @moduledoc """
  Provides struct and type for a SummarizeRequest
  """

  @type t :: %__MODULE__{
          documentSpecs: [map],
          preferredSummaryLength: integer | nil,
          query: String.t() | nil,
          timestamp: DateTime.t() | nil,
          trackingToken: String.t() | nil
        }

  defstruct [:documentSpecs, :preferredSummaryLength, :query, :timestamp, :trackingToken]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      documentSpecs: [:map],
      preferredSummaryLength: :integer,
      query: :string,
      timestamp: {:string, "date-time"},
      trackingToken: :string
    ]
  end
end
