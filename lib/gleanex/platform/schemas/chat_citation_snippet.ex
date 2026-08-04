defmodule Gleanex.Platform.ChatCitationSnippet do
  @moduledoc """
  Provides struct and type for a ChatCitationSnippet
  """

  @type t :: %__MODULE__{page_number: integer | nil, text: String.t()}

  defstruct [:page_number, :text]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [page_number: :integer, text: :string]
  end
end
