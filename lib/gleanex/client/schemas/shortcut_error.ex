defmodule Gleanex.Client.ShortcutError do
  @moduledoc """
  Provides struct and type for a ShortcutError
  """

  @type t :: %__MODULE__{errorType: String.t() | nil}

  defstruct [:errorType]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [errorType: {:enum, ["NO_PERMISSION", "INVALID_ID", "EXISTING_SHORTCUT", "INVALID_CHARS"]}]
  end
end
