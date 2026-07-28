defmodule Gleanex.Client.ChannelInviteInfo do
  @moduledoc """
  Provides struct and type for a ChannelInviteInfo
  """

  @type t :: %__MODULE__{
          channel: String.t() | nil,
          inviteTime: DateTime.t() | nil,
          inviter: Gleanex.Client.Person.t() | nil,
          isAutoInvite: boolean | nil,
          reminderTime: DateTime.t() | nil
        }

  defstruct [:channel, :inviteTime, :inviter, :isAutoInvite, :reminderTime]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      channel: {:enum, ["COMMUNICATION_CHANNEL_EMAIL", "COMMUNICATION_CHANNEL_SLACK"]},
      inviteTime: {:string, "date-time"},
      inviter: {Gleanex.Client.Person, :t},
      isAutoInvite: :boolean,
      reminderTime: {:string, "date-time"}
    ]
  end
end
