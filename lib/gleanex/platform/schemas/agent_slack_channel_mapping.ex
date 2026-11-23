defmodule Gleanex.Platform.AgentSlackChannelMapping do
  @moduledoc """
  Provides struct and type for a AgentSlackChannelMapping
  """

  @type t :: %__MODULE__{auto_engage: boolean | nil, channel_id: String.t()}

  defstruct [:auto_engage, :channel_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [auto_engage: :boolean, channel_id: :string]
  end
end
