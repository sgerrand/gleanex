defmodule Gleanex.Indexing.CheckDocumentAccessRequest do
  @moduledoc """
  Provides struct and type for a CheckDocumentAccessRequest
  """

  @type t :: %__MODULE__{
          datasource: String.t(),
          docId: String.t(),
          objectType: String.t(),
          userEmail: String.t()
        }

  defstruct [:datasource, :docId, :objectType, :userEmail]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [datasource: :string, docId: :string, objectType: :string, userEmail: :string]
  end
end
