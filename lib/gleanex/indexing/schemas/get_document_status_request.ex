defmodule Gleanex.Indexing.GetDocumentStatusRequest do
  @moduledoc """
  Provides struct and type for a GetDocumentStatusRequest
  """

  @type t :: %__MODULE__{datasource: String.t(), docId: String.t(), objectType: String.t()}

  defstruct [:datasource, :docId, :objectType]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [datasource: :string, docId: :string, objectType: :string]
  end
end
