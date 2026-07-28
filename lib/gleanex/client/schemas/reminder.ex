defmodule Gleanex.Client.Reminder do
  @moduledoc """
  Provides struct and type for a Reminder
  """

  @type t :: %__MODULE__{
          assignee: Gleanex.Client.Person.t(),
          createdAt: integer | nil,
          reason: String.t() | nil,
          remindAt: integer,
          requestor: Gleanex.Client.Person.t() | nil
        }

  defstruct [:assignee, :createdAt, :reason, :remindAt, :requestor]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      assignee: {Gleanex.Client.Person, :t},
      createdAt: :integer,
      reason: :string,
      remindAt: :integer,
      requestor: {Gleanex.Client.Person, :t}
    ]
  end
end
