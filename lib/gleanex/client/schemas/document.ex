defmodule Gleanex.Client.Document do
  @moduledoc """
  Provides struct and type for a Document
  """

  @type t :: %__MODULE__{
          connectorType: String.t() | nil,
          containerDocument: Gleanex.Client.Document.t() | nil,
          content: Gleanex.Client.DocumentContent.t() | nil,
          datasource: String.t() | nil,
          docType: String.t() | nil,
          id: String.t() | nil,
          metadata: Gleanex.Client.DocumentMetadata.t() | nil,
          parentDocument: Gleanex.Client.Document.t() | nil,
          sections: [Gleanex.Client.DocumentSection.t()] | nil,
          title: String.t() | nil,
          url: String.t() | nil
        }

  defstruct [
    :connectorType,
    :containerDocument,
    :content,
    :datasource,
    :docType,
    :id,
    :metadata,
    :parentDocument,
    :sections,
    :title,
    :url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      connectorType:
        {:enum,
         [
           "API_CRAWL",
           "BROWSER_CRAWL",
           "BROWSER_HISTORY",
           "BUILTIN",
           "FEDERATED_SEARCH",
           "PUSH_API",
           "WEB_CRAWL",
           "NATIVE_HISTORY"
         ]},
      containerDocument: {Gleanex.Client.Document, :t},
      content: {Gleanex.Client.DocumentContent, :t},
      datasource: :string,
      docType: :string,
      id: :string,
      metadata: {Gleanex.Client.DocumentMetadata, :t},
      parentDocument: {Gleanex.Client.Document, :t},
      sections: [{Gleanex.Client.DocumentSection, :t}],
      title: :string,
      url: :string
    ]
  end
end
