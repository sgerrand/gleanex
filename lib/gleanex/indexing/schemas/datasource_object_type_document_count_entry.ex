defmodule Gleanex.Indexing.DatasourceObjectTypeDocumentCountEntry do
  @moduledoc """
  Provides struct and type for a DatasourceObjectTypeDocumentCountEntry
  """

  @type t :: %__MODULE__{count: integer | nil, objectType: String.t() | nil}

  defstruct [:count, :objectType]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [count: :integer, objectType: :string]
  end
end
