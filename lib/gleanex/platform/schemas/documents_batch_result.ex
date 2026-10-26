defmodule Gleanex.Platform.DocumentsBatchResult do
  @moduledoc """
  Provides struct and type for a DocumentsBatchResult
  """

  @type t :: %__MODULE__{document: Gleanex.Platform.Document.t(), index: integer}

  defstruct [:document, :index]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [document: {Gleanex.Platform.Document, :t}, index: :integer]
  end
end
