defmodule Gleanex.Client.GetAnswerError do
  @moduledoc """
  Provides struct and type for a GetAnswerError
  """

  @type t :: %__MODULE__{
          answerAuthor: Gleanex.Client.Person.t() | nil,
          errorType: String.t() | nil
        }

  defstruct [:answerAuthor, :errorType]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      answerAuthor: {Gleanex.Client.Person, :t},
      errorType: {:enum, ["NO_PERMISSION", "INVALID_ID"]}
    ]
  end
end
