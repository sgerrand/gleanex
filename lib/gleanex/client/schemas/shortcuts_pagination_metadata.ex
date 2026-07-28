defmodule Gleanex.Client.ShortcutsPaginationMetadata do
  @moduledoc """
  Provides struct and type for a ShortcutsPaginationMetadata
  """

  @type t :: %__MODULE__{
          cursor: String.t() | nil,
          hasNextPage: boolean | nil,
          totalItemCount: integer | nil
        }

  defstruct [:cursor, :hasNextPage, :totalItemCount]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [cursor: :string, hasNextPage: :boolean, totalItemCount: :integer]
  end
end
