defmodule Gleanex.Client.CreateShortcutRequest do
  @moduledoc """
  Provides struct and type for a CreateShortcutRequest
  """

  @type t :: %__MODULE__{data: Gleanex.Client.ShortcutMutableProperties.t()}

  defstruct [:data]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [data: {Gleanex.Client.ShortcutMutableProperties, :t}]
  end
end
