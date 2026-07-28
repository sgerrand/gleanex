defmodule Gleanex.Client.RelatedQuestion do
  @moduledoc """
  Provides struct and type for a RelatedQuestion
  """

  @type t :: %__MODULE__{
          answer: String.t() | nil,
          question: String.t() | nil,
          ranges: [Gleanex.Client.TextRange.t()] | nil
        }

  defstruct [:answer, :question, :ranges]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [answer: :string, question: :string, ranges: [{Gleanex.Client.TextRange, :t}]]
  end
end
