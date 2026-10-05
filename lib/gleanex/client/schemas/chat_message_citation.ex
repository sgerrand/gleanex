defmodule Gleanex.Client.ChatMessageCitation do
  @moduledoc """
  Provides struct and type for a ChatMessageCitation
  """

  @type t :: %__MODULE__{
          referenceRanges: [Gleanex.Client.ReferenceRange.t()] | nil,
          sourceCustomEntity: Gleanex.Client.CustomEntity.t() | nil,
          sourceDocument: Gleanex.Client.Document.t() | nil,
          sourceFile: Gleanex.Client.ChatFile.t() | nil,
          sourcePerson: Gleanex.Client.Person.t() | nil,
          sourceSkill: Gleanex.Client.ChatSkill.t() | nil,
          trackingToken: String.t() | nil
        }

  defstruct [
    :referenceRanges,
    :sourceCustomEntity,
    :sourceDocument,
    :sourceFile,
    :sourcePerson,
    :sourceSkill,
    :trackingToken
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      referenceRanges: [{Gleanex.Client.ReferenceRange, :t}],
      sourceCustomEntity: {Gleanex.Client.CustomEntity, :t},
      sourceDocument: {Gleanex.Client.Document, :t},
      sourceFile: {Gleanex.Client.ChatFile, :t},
      sourcePerson: {Gleanex.Client.Person, :t},
      sourceSkill: {Gleanex.Client.ChatSkill, :t},
      trackingToken: :string
    ]
  end
end
