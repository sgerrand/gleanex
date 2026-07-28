defmodule Gleanex.Client.RecommendationsResponse do
  @moduledoc """
  Provides struct and type for a RecommendationsResponse
  """

  @type t :: %__MODULE__{
          backendTimeMillis: integer | nil,
          errorInfo: Gleanex.Client.ErrorInfo.t() | nil,
          generatedQnaResult: Gleanex.Client.GeneratedQna.t() | nil,
          requestID: String.t() | nil,
          results: [Gleanex.Client.SearchResult.t()] | nil,
          sessionInfo: Gleanex.Client.SessionInfo.t() | nil,
          structuredResults: [Gleanex.Client.StructuredResult.t()] | nil,
          trackingToken: String.t() | nil
        }

  defstruct [
    :backendTimeMillis,
    :errorInfo,
    :generatedQnaResult,
    :requestID,
    :results,
    :sessionInfo,
    :structuredResults,
    :trackingToken
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      backendTimeMillis: {:integer, "int64"},
      errorInfo: {Gleanex.Client.ErrorInfo, :t},
      generatedQnaResult: {Gleanex.Client.GeneratedQna, :t},
      requestID: :string,
      results: [{Gleanex.Client.SearchResult, :t}],
      sessionInfo: {Gleanex.Client.SessionInfo, :t},
      structuredResults: [{Gleanex.Client.StructuredResult, :t}],
      trackingToken: :string
    ]
  end
end
