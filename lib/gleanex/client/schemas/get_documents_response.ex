defmodule Gleanex.Client.GetDocumentsResponse do
  @moduledoc """
  Provides struct and type for a GetDocumentsResponse
  """

  @type t :: %__MODULE__{documents: map | nil}

  defstruct [:documents]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [documents: :map]
  end
end
