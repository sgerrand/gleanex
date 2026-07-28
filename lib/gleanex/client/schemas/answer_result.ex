defmodule Gleanex.Client.AnswerResult do
  @moduledoc """
  Provides struct and type for a AnswerResult
  """

  @type t :: %__MODULE__{
          answer: Gleanex.Client.Answer.t(),
          favoriteInfo: Gleanex.Client.FavoriteInfo.t() | nil,
          trackingToken: String.t() | nil
        }

  defstruct [:answer, :favoriteInfo, :trackingToken]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      answer: {Gleanex.Client.Answer, :t},
      favoriteInfo: {Gleanex.Client.FavoriteInfo, :t},
      trackingToken: :string
    ]
  end
end
