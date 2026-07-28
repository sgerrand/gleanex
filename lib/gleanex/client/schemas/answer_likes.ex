defmodule Gleanex.Client.AnswerLikes do
  @moduledoc """
  Provides struct and type for a AnswerLikes
  """

  @type t :: %__MODULE__{
          likedBy: [Gleanex.Client.AnswerLike.t()],
          likedByUser: boolean,
          numLikes: integer
        }

  defstruct [:likedBy, :likedByUser, :numLikes]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [likedBy: [{Gleanex.Client.AnswerLike, :t}], likedByUser: :boolean, numLikes: :integer]
  end
end
