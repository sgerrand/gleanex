defmodule Gleanex.Client.GetChatPagination do
  @moduledoc """
  Provides struct and type for a GetChatPagination
  """

  @type t :: %__MODULE__{
          endCursor: String.t() | nil,
          hasNextPage: boolean,
          hasPreviousPage: boolean,
          startCursor: String.t() | nil
        }

  defstruct [:endCursor, :hasNextPage, :hasPreviousPage, :startCursor]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [endCursor: :string, hasNextPage: :boolean, hasPreviousPage: :boolean, startCursor: :string]
  end
end
