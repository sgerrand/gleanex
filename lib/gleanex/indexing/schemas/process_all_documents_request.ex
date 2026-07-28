defmodule Gleanex.Indexing.ProcessAllDocumentsRequest do
  @moduledoc """
  Provides struct and type for a ProcessAllDocumentsRequest
  """

  @type t :: %__MODULE__{datasource: String.t() | nil}

  defstruct [:datasource]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [datasource: :string]
  end
end
