defmodule Gleanex.Client.DisplayableListItemUIConfig do
  @moduledoc """
  Provides struct and type for a DisplayableListItemUIConfig
  """

  @type t :: %__MODULE__{showNewIndicator: boolean | nil}

  defstruct [:showNewIndicator]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [showNewIndicator: :boolean]
  end
end
