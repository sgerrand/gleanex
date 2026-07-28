defmodule Gleanex.Client.ListAnswersRequest do
  @moduledoc """
  Provides struct and type for a ListAnswersRequest
  """

  @type t :: %__MODULE__{boardId: integer | nil}

  defstruct [:boardId]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [boardId: :integer]
  end
end
