defmodule Gleanex.Indexing.DebugDocumentLifecycleRequest do
  @moduledoc """
  Provides struct and type for a DebugDocumentLifecycleRequest
  """

  @type t :: %__MODULE__{
          docId: String.t(),
          maxEvents: integer | nil,
          objectType: String.t(),
          startDate: String.t() | nil
        }

  defstruct [:docId, :maxEvents, :objectType, :startDate]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [docId: :string, maxEvents: :integer, objectType: :string, startDate: :string]
  end
end
