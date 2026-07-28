defmodule Gleanex.Client.DigestSection do
  @moduledoc """
  Provides struct and type for a DigestSection
  """

  @type t :: %__MODULE__{
          channelName: String.t() | nil,
          channelType: String.t() | nil,
          displayName: String.t() | nil,
          id: String.t(),
          instanceId: String.t() | nil,
          type: String.t(),
          updates: [Gleanex.Client.DigestUpdate.t()],
          url: String.t() | nil
        }

  defstruct [:channelName, :channelType, :displayName, :id, :instanceId, :type, :updates, :url]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      channelName: :string,
      channelType: :string,
      displayName: :string,
      id: :string,
      instanceId: :string,
      type: {:enum, ["CHANNEL", "MENTIONS", "TOPIC"]},
      updates: [{Gleanex.Client.DigestUpdate, :t}],
      url: :string
    ]
  end
end
