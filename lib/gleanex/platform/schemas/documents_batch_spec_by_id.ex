defmodule Gleanex.Platform.DocumentsBatchSpecById do
  @moduledoc """
  Provides struct and type for a DocumentsBatchSpecById
  """

  @type t :: %__MODULE__{document_id: String.t()}

  defstruct [:document_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [document_id: :string]
  end
end
