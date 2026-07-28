defmodule Gleanex.Client.ChatMessageFragment do
  @moduledoc """
  Provides struct and type for a ChatMessageFragment
  """

  @type t :: %__MODULE__{
          action: Gleanex.Client.ToolInfo.t() | nil,
          citation: Gleanex.Client.ChatMessageCitation.t() | nil,
          file: Gleanex.Client.ChatFile.t() | nil,
          querySuggestion: Gleanex.Client.QuerySuggestion.t() | nil,
          serverToolRequest: Gleanex.Client.ServerToolRequest.t() | nil,
          serverToolResponse: Gleanex.Client.ServerToolResponse.t() | nil,
          structuredResults: [Gleanex.Client.StructuredResult.t()] | nil,
          text: String.t() | nil,
          trackingToken: String.t() | nil
        }

  defstruct [
    :action,
    :citation,
    :file,
    :querySuggestion,
    :serverToolRequest,
    :serverToolResponse,
    :structuredResults,
    :text,
    :trackingToken
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      action: {Gleanex.Client.ToolInfo, :t},
      citation: {Gleanex.Client.ChatMessageCitation, :t},
      file: {Gleanex.Client.ChatFile, :t},
      querySuggestion: {Gleanex.Client.QuerySuggestion, :t},
      serverToolRequest: {Gleanex.Client.ServerToolRequest, :t},
      serverToolResponse: {Gleanex.Client.ServerToolResponse, :t},
      structuredResults: [{Gleanex.Client.StructuredResult, :t}],
      text: :string,
      trackingToken: :string
    ]
  end
end
