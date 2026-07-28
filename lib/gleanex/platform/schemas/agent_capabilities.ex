defmodule Gleanex.Platform.AgentCapabilities do
  @moduledoc """
  Provides struct and type for a AgentCapabilities
  """

  @type t :: %__MODULE__{"ap.io.messages": boolean | nil, "ap.io.streaming": boolean | nil}

  defstruct [:"ap.io.messages", :"ap.io.streaming"]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    ["ap.io.messages": :boolean, "ap.io.streaming": :boolean]
  end
end
