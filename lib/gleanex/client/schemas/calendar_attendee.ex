defmodule Gleanex.Client.CalendarAttendee do
  @moduledoc """
  Provides struct and type for a CalendarAttendee
  """

  @type t :: %__MODULE__{
          groupAttendees: [Gleanex.Client.CalendarAttendee.t()] | nil,
          isInGroup: boolean | nil,
          isOrganizer: boolean | nil,
          person: Gleanex.Client.Person.t(),
          responseStatus: String.t() | nil
        }

  defstruct [:groupAttendees, :isInGroup, :isOrganizer, :person, :responseStatus]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      groupAttendees: [{Gleanex.Client.CalendarAttendee, :t}],
      isInGroup: :boolean,
      isOrganizer: :boolean,
      person: {Gleanex.Client.Person, :t},
      responseStatus: {:enum, ["ACCEPTED", "DECLINED", "NO_RESPONSE", "TENTATIVE"]}
    ]
  end
end
