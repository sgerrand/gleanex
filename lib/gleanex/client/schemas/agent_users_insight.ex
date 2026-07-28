defmodule Gleanex.Client.AgentUsersInsight do
  @moduledoc """
  Provides struct and type for a AgentUsersInsight
  """

  @type t :: %__MODULE__{
          agentsCreatedCount: integer | nil,
          agentsUsedCount: integer | nil,
          averageRunsPerDayCount: number | nil,
          departmentName: String.t() | nil,
          person: Gleanex.Client.Person.t() | nil,
          runCount: integer | nil
        }

  defstruct [
    :agentsCreatedCount,
    :agentsUsedCount,
    :averageRunsPerDayCount,
    :departmentName,
    :person,
    :runCount
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      agentsCreatedCount: :integer,
      agentsUsedCount: :integer,
      averageRunsPerDayCount: {:number, "float"},
      departmentName: :string,
      person: {Gleanex.Client.Person, :t},
      runCount: :integer
    ]
  end
end
