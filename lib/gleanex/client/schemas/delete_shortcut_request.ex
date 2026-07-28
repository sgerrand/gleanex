defmodule Gleanex.Client.DeleteShortcutRequest do
  @moduledoc """
  Provides struct and type for a DeleteShortcutRequest
  """

  @type t :: %__MODULE__{id: integer | nil}

  defstruct [:id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [id: :integer]
  end
end
