defmodule Gleanex.Indexing.ContentDefinition do
  @moduledoc """
  Provides struct and type for a ContentDefinition
  """

  @type t :: %__MODULE__{
          binaryContent: String.t() | nil,
          mimeType: String.t(),
          textContent: String.t() | nil
        }

  defstruct [:binaryContent, :mimeType, :textContent]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [binaryContent: :string, mimeType: :string, textContent: :string]
  end
end
