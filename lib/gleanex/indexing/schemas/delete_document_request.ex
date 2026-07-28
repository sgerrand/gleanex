defmodule Gleanex.Indexing.DeleteDocumentRequest do
  @moduledoc """
  Provides struct and type for a DeleteDocumentRequest
  """

  @type t :: %__MODULE__{
          datasource: String.t(),
          id: String.t(),
          objectType: String.t(),
          version: integer | nil
        }

  defstruct [:datasource, :id, :objectType, :version]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [datasource: :string, id: :string, objectType: :string, version: {:integer, "int64"}]
  end
end
