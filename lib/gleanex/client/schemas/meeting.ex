defmodule Gleanex.Client.Meeting do
  @moduledoc """
  Provides struct and type for a Meeting
  """

  @type t :: %__MODULE__{
          attendees: Gleanex.Client.CalendarAttendees.t() | nil,
          conferenceProvider: String.t() | nil,
          conferenceUri: String.t() | nil,
          description: String.t() | nil,
          endTime: DateTime.t() | nil,
          id: String.t() | nil,
          isCancelled: boolean | nil,
          location: String.t() | nil,
          responseStatus: String.t() | nil,
          startTime: DateTime.t() | nil,
          title: String.t() | nil,
          url: String.t() | nil
        }

  defstruct [
    :attendees,
    :conferenceProvider,
    :conferenceUri,
    :description,
    :endTime,
    :id,
    :isCancelled,
    :location,
    :responseStatus,
    :startTime,
    :title,
    :url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      attendees: {Gleanex.Client.CalendarAttendees, :t},
      conferenceProvider: :string,
      conferenceUri: :string,
      description: :string,
      endTime: {:string, "date-time"},
      id: :string,
      isCancelled: :boolean,
      location: :string,
      responseStatus: :string,
      startTime: {:string, "date-time"},
      title: :string,
      url: :string
    ]
  end
end
