defmodule Gleanex.Client.GetChatApplicationResponse do
  @moduledoc """
  Provides struct and type for a GetChatApplicationResponse
  """

  @type t :: %__MODULE__{application: map | nil}

  defstruct [:application]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [application: :map]
  end
end
