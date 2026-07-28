defmodule Gleanex.Client.StructuredTextItem do
  @moduledoc """
  Provides struct and type for a StructuredTextItem
  """

  @type t :: %__MODULE__{
          document: Gleanex.Client.Document.t() | nil,
          link: String.t() | nil,
          structuredResult: Gleanex.Client.StructuredResult.t() | nil,
          text: String.t() | nil
        }

  defstruct [:document, :link, :structuredResult, :text]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      document: {Gleanex.Client.Document, :t},
      link: :string,
      structuredResult: {Gleanex.Client.StructuredResult, :t},
      text: :string
    ]
  end
end
