defmodule Gleanex.Client.CollectionItem do
  @moduledoc """
  Provides struct and type for a CollectionItem
  """

  @type t :: %__MODULE__{
          collection: Gleanex.Client.Collection.t() | nil,
          collectionId: integer | nil,
          createdAt: DateTime.t() | nil,
          createdBy: Gleanex.Client.Person.t() | nil,
          description: String.t() | nil,
          document: Gleanex.Client.Document.t() | nil,
          documentId: String.t() | nil,
          icon: String.t() | nil,
          itemId: String.t() | nil,
          itemType: String.t() | nil,
          name: String.t() | nil,
          shortcut: Gleanex.Client.Shortcut.t() | nil,
          url: String.t() | nil
        }

  defstruct [
    :collection,
    :collectionId,
    :createdAt,
    :createdBy,
    :description,
    :document,
    :documentId,
    :icon,
    :itemId,
    :itemType,
    :name,
    :shortcut,
    :url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      collection: {Gleanex.Client.Collection, :t},
      collectionId: :integer,
      createdAt: {:string, "date-time"},
      createdBy: {Gleanex.Client.Person, :t},
      description: :string,
      document: {Gleanex.Client.Document, :t},
      documentId: :string,
      icon: :string,
      itemId: :string,
      itemType: {:enum, ["DOCUMENT", "TEXT", "URL", "COLLECTION"]},
      name: :string,
      shortcut: {Gleanex.Client.Shortcut, :t},
      url: :string
    ]
  end
end
