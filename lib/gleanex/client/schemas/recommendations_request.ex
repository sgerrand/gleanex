defmodule Gleanex.Client.RecommendationsRequest do
  @moduledoc """
  Provides struct and type for a RecommendationsRequest
  """

  @type t :: %__MODULE__{
          maxSnippetSize: integer | nil,
          pageSize: integer | nil,
          recommendationDocumentSpec: map | nil,
          requestOptions: Gleanex.Client.RecommendationsRequestOptions.t() | nil,
          sessionInfo: Gleanex.Client.SessionInfo.t() | nil,
          sourceDocument: Gleanex.Client.Document.t() | nil,
          timestamp: DateTime.t() | nil,
          trackingToken: String.t() | nil
        }

  defstruct [
    :maxSnippetSize,
    :pageSize,
    :recommendationDocumentSpec,
    :requestOptions,
    :sessionInfo,
    :sourceDocument,
    :timestamp,
    :trackingToken
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      maxSnippetSize: :integer,
      pageSize: :integer,
      recommendationDocumentSpec: :map,
      requestOptions: {Gleanex.Client.RecommendationsRequestOptions, :t},
      sessionInfo: {Gleanex.Client.SessionInfo, :t},
      sourceDocument: {Gleanex.Client.Document, :t},
      timestamp: {:string, "date-time"},
      trackingToken: :string
    ]
  end
end
