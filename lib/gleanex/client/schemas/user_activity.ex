defmodule Gleanex.Client.UserActivity do
  @moduledoc """
  Provides struct and type for a UserActivity
  """

  @type t :: %__MODULE__{
          action: String.t() | nil,
          actor: Gleanex.Client.Person.t() | nil,
          aggregateVisitCount: Gleanex.Client.CountInfo.t() | nil,
          timestamp: integer | nil
        }

  defstruct [:action, :actor, :aggregateVisitCount, :timestamp]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      action:
        {:enum,
         [
           "ADD",
           "ADD_REMINDER",
           "CLICK",
           "COMMENT",
           "DELETE",
           "DISMISS",
           "EDIT",
           "MENTION",
           "MOVE",
           "OTHER",
           "RESTORE",
           "UNKNOWN",
           "VERIFY",
           "VIEW"
         ]},
      actor: {Gleanex.Client.Person, :t},
      aggregateVisitCount: {Gleanex.Client.CountInfo, :t},
      timestamp: :integer
    ]
  end
end
