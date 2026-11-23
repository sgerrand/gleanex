defmodule Gleanex.Platform.DocumentGetResponse do
  @moduledoc """
  Provides struct and type for a DocumentGetResponse
  """

  @type t :: %__MODULE__{document: Gleanex.Platform.Document.t(), request_id: String.t()}

  defstruct [:document, :request_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [document: {Gleanex.Platform.Document, :t}, request_id: :string]
  end
end
