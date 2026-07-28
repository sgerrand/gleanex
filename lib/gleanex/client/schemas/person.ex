defmodule Gleanex.Client.Person do
  @moduledoc """
  Provides struct and type for a Person
  """

  @type t :: %__MODULE__{
          metadata: Gleanex.Client.PersonMetadata.t() | nil,
          name: String.t(),
          obfuscatedId: String.t(),
          relatedDocuments: [Gleanex.Client.RelatedDocuments.t()] | nil
        }

  defstruct [:metadata, :name, :obfuscatedId, :relatedDocuments]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      metadata: {Gleanex.Client.PersonMetadata, :t},
      name: :string,
      obfuscatedId: :string,
      relatedDocuments: [{Gleanex.Client.RelatedDocuments, :t}]
    ]
  end
end
