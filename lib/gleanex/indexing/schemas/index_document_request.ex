defmodule Gleanex.Indexing.IndexDocumentRequest do
  @moduledoc """
  Provides struct and type for a IndexDocumentRequest
  """

  @type t :: %__MODULE__{
          document: Gleanex.Indexing.DocumentDefinition.t(),
          version: integer | nil
        }

  defstruct [:document, :version]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [document: {Gleanex.Indexing.DocumentDefinition, :t}, version: {:integer, "int64"}]
  end
end
