defmodule Gleanex.Indexing.CommentDefinition do
  @moduledoc """
  Provides struct and type for a CommentDefinition
  """

  @type t :: %__MODULE__{
          author: Gleanex.Indexing.UserReferenceDefinition.t() | nil,
          content: Gleanex.Indexing.ContentDefinition.t() | nil,
          createdAt: integer | nil,
          id: String.t(),
          updatedAt: integer | nil,
          updatedBy: Gleanex.Indexing.UserReferenceDefinition.t() | nil
        }

  defstruct [:author, :content, :createdAt, :id, :updatedAt, :updatedBy]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      author: {Gleanex.Indexing.UserReferenceDefinition, :t},
      content: {Gleanex.Indexing.ContentDefinition, :t},
      createdAt: {:integer, "int64"},
      id: :string,
      updatedAt: {:integer, "int64"},
      updatedBy: {Gleanex.Indexing.UserReferenceDefinition, :t}
    ]
  end
end
