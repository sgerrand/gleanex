defmodule Gleanex.Client.ListAnswersResponse do
  @moduledoc """
  Provides struct and type for a ListAnswersResponse
  """

  @type t :: %__MODULE__{answerResults: [Gleanex.Client.AnswerResult.t()]}

  defstruct [:answerResults]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [answerResults: [{Gleanex.Client.AnswerResult, :t}]]
  end
end
