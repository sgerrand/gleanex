defmodule Gleanex.Client.InviteInfo do
  @moduledoc """
  Provides struct and type for a InviteInfo
  """

  @type t :: %__MODULE__{
          inviteTime: DateTime.t() | nil,
          inviter: Gleanex.Client.Person.t() | nil,
          invites: [Gleanex.Client.ChannelInviteInfo.t()] | nil,
          reminderTime: DateTime.t() | nil,
          signUpTime: DateTime.t() | nil
        }

  defstruct [:inviteTime, :inviter, :invites, :reminderTime, :signUpTime]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      inviteTime: {:string, "date-time"},
      inviter: {Gleanex.Client.Person, :t},
      invites: [{Gleanex.Client.ChannelInviteInfo, :t}],
      reminderTime: {:string, "date-time"},
      signUpTime: {:string, "date-time"}
    ]
  end
end
