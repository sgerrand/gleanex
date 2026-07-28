defmodule Gleanex.Client.GetAnswerResponse do
  @moduledoc """
  Provides struct and type for a GetAnswerResponse
  """

  @type t :: %__MODULE__{
          answerResult: Gleanex.Client.AnswerResult.t() | nil,
          error: Gleanex.Client.GetAnswerError.t() | nil
        }

  defstruct [:answerResult, :error]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [answerResult: {Gleanex.Client.AnswerResult, :t}, error: {Gleanex.Client.GetAnswerError, :t}]
  end
end
