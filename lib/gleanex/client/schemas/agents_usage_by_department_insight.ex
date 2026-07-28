defmodule Gleanex.Client.AgentsUsageByDepartmentInsight do
  @moduledoc """
  Provides struct and type for a AgentsUsageByDepartmentInsight
  """

  @type t :: %__MODULE__{
          agentAdoptionRate: number | nil,
          agentId: String.t() | nil,
          agentName: String.t() | nil,
          department: String.t() | nil,
          icon: Gleanex.Client.IconConfig.t() | nil,
          isDeleted: boolean | nil,
          runCount: integer | nil,
          userCount: integer | nil
        }

  defstruct [
    :agentAdoptionRate,
    :agentId,
    :agentName,
    :department,
    :icon,
    :isDeleted,
    :runCount,
    :userCount
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      agentAdoptionRate: {:number, "float"},
      agentId: :string,
      agentName: :string,
      department: :string,
      icon: {Gleanex.Client.IconConfig, :t},
      isDeleted: :boolean,
      runCount: :integer,
      userCount: :integer
    ]
  end
end
