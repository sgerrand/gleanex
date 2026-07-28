defmodule Gleanex.Client.CalendarAttendees do
  @moduledoc """
  Provides struct and type for a CalendarAttendees
  """

  @type t :: %__MODULE__{
          isLimit: boolean | nil,
          numAccepted: integer | nil,
          numDeclined: integer | nil,
          numNoResponse: integer | nil,
          numTentative: integer | nil,
          people: [Gleanex.Client.CalendarAttendee.t()] | nil,
          total: integer | nil
        }

  defstruct [:isLimit, :numAccepted, :numDeclined, :numNoResponse, :numTentative, :people, :total]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      isLimit: :boolean,
      numAccepted: :integer,
      numDeclined: :integer,
      numNoResponse: :integer,
      numTentative: :integer,
      people: [{Gleanex.Client.CalendarAttendee, :t}],
      total: :integer
    ]
  end
end
