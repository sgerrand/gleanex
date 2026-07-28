defmodule Gleanex.Client.TextRange do
  @moduledoc """
  Provides struct and type for a TextRange
  """

  @type t :: %__MODULE__{
          document: Gleanex.Client.Document.t() | nil,
          endIndex: integer | nil,
          startIndex: integer,
          type: String.t() | nil,
          url: String.t() | nil
        }

  defstruct [:document, :endIndex, :startIndex, :type, :url]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      document: {Gleanex.Client.Document, :t},
      endIndex: :integer,
      startIndex: :integer,
      type: {:enum, ["BOLD", "CITATION", "HIGHLIGHT", "LINK"]},
      url: :string
    ]
  end
end
