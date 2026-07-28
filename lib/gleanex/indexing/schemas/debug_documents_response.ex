defmodule Gleanex.Indexing.DebugDocumentsResponse do
  @moduledoc """
  Provides struct and type for a DebugDocumentsResponse
  """

  @type t :: %__MODULE__{
          documentStatuses: [Gleanex.Indexing.DebugDocumentsResponseItem.t()] | nil
        }

  defstruct [:documentStatuses]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [documentStatuses: [{Gleanex.Indexing.DebugDocumentsResponseItem, :t}]]
  end
end
