defmodule Gleanex.Client.SearchRequest do
  @moduledoc """
  Provides struct and type for a SearchRequest
  """

  @type t :: %__MODULE__{
          cursor: String.t() | nil,
          disableSpellcheck: boolean | nil,
          inputDetails: Gleanex.Client.SearchRequestInputDetails.t() | nil,
          maxSnippetSize: integer | nil,
          pageSize: integer | nil,
          query: String.t(),
          requestOptions: Gleanex.Client.SearchRequestOptions.t() | nil,
          resultTabIds: [String.t()] | nil,
          sessionInfo: Gleanex.Client.SessionInfo.t() | nil,
          sourceDocument: Gleanex.Client.Document.t() | nil,
          timeoutMillis: integer | nil,
          timestamp: DateTime.t() | nil,
          trackingToken: String.t() | nil
        }

  defstruct [
    :cursor,
    :disableSpellcheck,
    :inputDetails,
    :maxSnippetSize,
    :pageSize,
    :query,
    :requestOptions,
    :resultTabIds,
    :sessionInfo,
    :sourceDocument,
    :timeoutMillis,
    :timestamp,
    :trackingToken
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      cursor: :string,
      disableSpellcheck: :boolean,
      inputDetails: {Gleanex.Client.SearchRequestInputDetails, :t},
      maxSnippetSize: :integer,
      pageSize: :integer,
      query: :string,
      requestOptions: {Gleanex.Client.SearchRequestOptions, :t},
      resultTabIds: [:string],
      sessionInfo: {Gleanex.Client.SessionInfo, :t},
      sourceDocument: {Gleanex.Client.Document, :t},
      timeoutMillis: :integer,
      timestamp: {:string, "date-time"},
      trackingToken: :string
    ]
  end
end
