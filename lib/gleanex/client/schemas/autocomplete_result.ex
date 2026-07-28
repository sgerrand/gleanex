defmodule Gleanex.Client.AutocompleteResult do
  @moduledoc """
  Provides struct and type for a AutocompleteResult
  """

  @type t :: %__MODULE__{
          document: Gleanex.Client.Document.t() | nil,
          keywords: [String.t()] | nil,
          operatorMetadata: Gleanex.Client.OperatorMetadata.t() | nil,
          quicklink: Gleanex.Client.Quicklink.t() | nil,
          ranges: [Gleanex.Client.TextRange.t()] | nil,
          result: String.t(),
          resultType: String.t() | nil,
          score: number | nil,
          structuredResult: Gleanex.Client.StructuredResult.t() | nil,
          trackingToken: String.t() | nil,
          url: String.t() | nil
        }

  defstruct [
    :document,
    :keywords,
    :operatorMetadata,
    :quicklink,
    :ranges,
    :result,
    :resultType,
    :score,
    :structuredResult,
    :trackingToken,
    :url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      document: {Gleanex.Client.Document, :t},
      keywords: [:string],
      operatorMetadata: {Gleanex.Client.OperatorMetadata, :t},
      quicklink: {Gleanex.Client.Quicklink, :t},
      ranges: [{Gleanex.Client.TextRange, :t}],
      result: :string,
      resultType:
        {:enum,
         [
           "ADDITIONAL_DOCUMENT",
           "APP",
           "BROWSER_HISTORY",
           "DATASOURCE",
           "DOCUMENT",
           "ENTITY",
           "GOLINK",
           "HISTORY",
           "CHAT_HISTORY",
           "NEW_CHAT",
           "OPERATOR",
           "OPERATOR_VALUE",
           "QUICKLINK",
           "SUGGESTION"
         ]},
      score: :number,
      structuredResult: {Gleanex.Client.StructuredResult, :t},
      trackingToken: :string,
      url: :string
    ]
  end
end
