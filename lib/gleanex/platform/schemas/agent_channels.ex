defmodule Gleanex.Platform.AgentChannels do
  @moduledoc """
  Provides struct and type for a AgentChannels
  """

  @type t :: %__MODULE__{slack: Gleanex.Platform.AgentSlackChannel.t() | nil}

  defstruct [:slack]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [slack: {Gleanex.Platform.AgentSlackChannel, :t}]
  end
end
