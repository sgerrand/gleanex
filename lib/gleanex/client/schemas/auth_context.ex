defmodule Gleanex.Client.AuthContext do
  @moduledoc """
  Provides struct and type for a AuthContext
  """

  @type t :: %__MODULE__{serverId: String.t() | nil}

  defstruct [:serverId]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [serverId: :string]
  end
end
