defmodule Gleanex.Client.PeopleRequest do
  @moduledoc """
  Provides struct and type for a PeopleRequest
  """

  @type t :: %__MODULE__{
          emailIds: [String.t()] | nil,
          includeFields: [String.t()] | nil,
          includeTypes: [String.t()] | nil,
          obfuscatedIds: [String.t()] | nil,
          source: String.t() | nil,
          timezoneOffset: integer | nil
        }

  defstruct [:emailIds, :includeFields, :includeTypes, :obfuscatedIds, :source, :timezoneOffset]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      emailIds: [:string],
      includeFields: [
        enum: [
          "BADGES",
          "BUSY_EVENTS",
          "DOCUMENT_ACTIVITY",
          "INVITE_INFO",
          "PEOPLE_DISTANCE",
          "PERMISSIONS",
          "PEOPLE_DETAILS",
          "MANAGEMENT_DETAILS",
          "PEOPLE_PROFILE_SETTINGS",
          "PEOPLE_WITHOUT_MANAGER"
        ]
      ],
      includeTypes: [enum: ["PEOPLE_WITHOUT_MANAGER", "INVALID_ENTITIES"]],
      obfuscatedIds: [:string],
      source: :string,
      timezoneOffset: :integer
    ]
  end
end
