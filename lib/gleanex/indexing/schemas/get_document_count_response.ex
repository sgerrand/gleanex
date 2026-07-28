defmodule Gleanex.Indexing.GetDocumentCountResponse do
  @moduledoc """
  Provides struct and type for a GetDocumentCountResponse
  """

  @type t :: %__MODULE__{documentCount: integer | nil}

  defstruct [:documentCount]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [documentCount: :integer]
  end
end
