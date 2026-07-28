defmodule Gleanex.Client.UserActivityInsight do
  @moduledoc """
  Provides struct and type for a UserActivityInsight
  """

  @type t :: %__MODULE__{
          activeDayCount: Gleanex.Client.CountInfo.t() | nil,
          activity: String.t(),
          activityCount: Gleanex.Client.CountInfo.t() | nil,
          lastActivityTimestamp: integer | nil,
          user: Gleanex.Client.Person.t()
        }

  defstruct [:activeDayCount, :activity, :activityCount, :lastActivityTimestamp, :user]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      activeDayCount: {Gleanex.Client.CountInfo, :t},
      activity: {:enum, ["ALL", "SEARCH"]},
      activityCount: {Gleanex.Client.CountInfo, :t},
      lastActivityTimestamp: :integer,
      user: {Gleanex.Client.Person, :t}
    ]
  end
end
