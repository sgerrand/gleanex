defmodule Gleanex.Client.VerificationMetadata do
  @moduledoc """
  Provides struct and type for a VerificationMetadata
  """

  @type t :: %__MODULE__{
          candidateVerifiers: [Gleanex.Client.Person.t()] | nil,
          document: Gleanex.Client.Document.t() | nil,
          expirationTs: integer | nil,
          lastReminder: Gleanex.Client.Reminder.t() | nil,
          lastVerificationTs: integer | nil,
          lastVerifier: Gleanex.Client.Person.t() | nil,
          reminders: [Gleanex.Client.Reminder.t()] | nil,
          visitorCount: [Gleanex.Client.CountInfo.t()] | nil
        }

  defstruct [
    :candidateVerifiers,
    :document,
    :expirationTs,
    :lastReminder,
    :lastVerificationTs,
    :lastVerifier,
    :reminders,
    :visitorCount
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      candidateVerifiers: [{Gleanex.Client.Person, :t}],
      document: {Gleanex.Client.Document, :t},
      expirationTs: :integer,
      lastReminder: {Gleanex.Client.Reminder, :t},
      lastVerificationTs: :integer,
      lastVerifier: {Gleanex.Client.Person, :t},
      reminders: [{Gleanex.Client.Reminder, :t}],
      visitorCount: [{Gleanex.Client.CountInfo, :t}]
    ]
  end
end
