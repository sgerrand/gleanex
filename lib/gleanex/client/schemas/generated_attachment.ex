defmodule Gleanex.Client.GeneratedAttachment do
  @moduledoc """
  Provides struct and type for a GeneratedAttachment
  """

  @type t :: %__MODULE__{
          content: [Gleanex.Client.GeneratedAttachmentContent.t()] | nil,
          customer: Gleanex.Client.Customer.t() | nil,
          documents: [Gleanex.Client.Document.t()] | nil,
          externalLinks: [Gleanex.Client.StructuredLink.t()] | nil,
          person: Gleanex.Client.Person.t() | nil,
          strategyName: String.t() | nil
        }

  defstruct [:content, :customer, :documents, :externalLinks, :person, :strategyName]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      content: [{Gleanex.Client.GeneratedAttachmentContent, :t}],
      customer: {Gleanex.Client.Customer, :t},
      documents: [{Gleanex.Client.Document, :t}],
      externalLinks: [{Gleanex.Client.StructuredLink, :t}],
      person: {Gleanex.Client.Person, :t},
      strategyName:
        {:enum,
         [
           "customerCard",
           "news",
           "call",
           "email",
           "meetingNotes",
           "linkedIn",
           "relevantDocuments",
           "chatFollowUps",
           "conversations"
         ]}
    ]
  end
end
