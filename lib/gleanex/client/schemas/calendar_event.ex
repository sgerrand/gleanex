defmodule Gleanex.Client.CalendarEvent do
  @moduledoc """
  Provides struct and type for a CalendarEvent
  """

  @type t :: %__MODULE__{
          attendees: Gleanex.Client.CalendarAttendees.t() | nil,
          classifications: [Gleanex.Client.EventClassification.t()] | nil,
          conferenceData: Gleanex.Client.ConferenceData.t() | nil,
          datasource: String.t() | nil,
          description: String.t() | nil,
          eventType: String.t() | nil,
          generatedAttachments: [Gleanex.Client.GeneratedAttachment.t()] | nil,
          hasTranscript: boolean | nil,
          id: String.t(),
          isOrganizer: boolean | nil,
          location: String.t() | nil,
          roomBookingStatus: String.t() | nil,
          roomName: String.t() | nil,
          time: Gleanex.Client.TimeInterval.t() | nil,
          transcriptUrl: String.t() | nil,
          url: String.t()
        }

  defstruct [
    :attendees,
    :classifications,
    :conferenceData,
    :datasource,
    :description,
    :eventType,
    :generatedAttachments,
    :hasTranscript,
    :id,
    :isOrganizer,
    :location,
    :roomBookingStatus,
    :roomName,
    :time,
    :transcriptUrl,
    :url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      attendees: {Gleanex.Client.CalendarAttendees, :t},
      classifications: [{Gleanex.Client.EventClassification, :t}],
      conferenceData: {Gleanex.Client.ConferenceData, :t},
      datasource: :string,
      description: :string,
      eventType: {:enum, ["DEFAULT", "OUT_OF_OFFICE"]},
      generatedAttachments: [{Gleanex.Client.GeneratedAttachment, :t}],
      hasTranscript: :boolean,
      id: :string,
      isOrganizer: :boolean,
      location: :string,
      roomBookingStatus: {:enum, ["NONE", "ACCEPTED", "DECLINED", "PENDING"]},
      roomName: :string,
      time: {Gleanex.Client.TimeInterval, :t},
      transcriptUrl: :string,
      url: :string
    ]
  end
end
