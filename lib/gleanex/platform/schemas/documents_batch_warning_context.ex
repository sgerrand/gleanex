defmodule Gleanex.Platform.DocumentsBatchWarningContext do
  @moduledoc """
  Provides struct and type for a DocumentsBatchWarningContext
  """

  @type t :: %__MODULE__{document_id: String.t() | nil, index: integer, url: String.t() | nil}

  defstruct [:document_id, :index, :url]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [document_id: :string, index: :integer, url: :string]
  end
end
