defmodule Gleanex.Client.UpdateShortcutResponse do
  @moduledoc """
  Provides struct and type for a UpdateShortcutResponse
  """

  @type t :: %__MODULE__{
          error: Gleanex.Client.ShortcutError.t() | nil,
          shortcut: Gleanex.Client.Shortcut.t() | nil
        }

  defstruct [:error, :shortcut]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [error: {Gleanex.Client.ShortcutError, :t}, shortcut: {Gleanex.Client.Shortcut, :t}]
  end
end
