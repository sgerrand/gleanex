defmodule Gleanex.Indexing.CheckDocumentAccessResponse do
  @moduledoc """
  Provides struct and type for a CheckDocumentAccessResponse
  """

  @type t :: %__MODULE__{hasAccess: boolean | nil}

  defstruct [:hasAccess]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [hasAccess: :boolean]
  end
end
