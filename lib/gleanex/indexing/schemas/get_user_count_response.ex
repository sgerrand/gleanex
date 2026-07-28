defmodule Gleanex.Indexing.GetUserCountResponse do
  @moduledoc """
  Provides struct and type for a GetUserCountResponse
  """

  @type t :: %__MODULE__{userCount: integer | nil}

  defstruct [:userCount]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [userCount: :integer]
  end
end
