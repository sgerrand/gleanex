defmodule Gleanex.Client.ExtractedQnA do
  @moduledoc """
  Provides struct and type for a ExtractedQnA
  """

  @type t :: %__MODULE__{
          heading: String.t() | nil,
          question: String.t() | nil,
          questionResult: Gleanex.Client.SearchResult.t() | nil
        }

  defstruct [:heading, :question, :questionResult]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [heading: :string, question: :string, questionResult: {Gleanex.Client.SearchResult, :t}]
  end
end
