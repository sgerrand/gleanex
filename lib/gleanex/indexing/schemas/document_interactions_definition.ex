defmodule Gleanex.Indexing.DocumentInteractionsDefinition do
  @moduledoc """
  Provides struct and type for a DocumentInteractionsDefinition
  """

  @type t :: %__MODULE__{
          numComments: integer | nil,
          numLikes: integer | nil,
          numViews: integer | nil
        }

  defstruct [:numComments, :numLikes, :numViews]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [numComments: :integer, numLikes: :integer, numViews: :integer]
  end
end
