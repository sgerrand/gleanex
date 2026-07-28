defmodule Gleanex.Client.ReminderRequest do
  @moduledoc """
  Provides struct and type for a ReminderRequest
  """

  @type t :: %__MODULE__{
          assignee: String.t() | nil,
          documentId: String.t(),
          reason: String.t() | nil,
          remindInDays: integer | nil
        }

  defstruct [:assignee, :documentId, :reason, :remindInDays]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [assignee: :string, documentId: :string, reason: :string, remindInDays: :integer]
  end
end
