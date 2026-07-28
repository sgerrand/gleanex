defmodule Gleanex.Client.AgentUseCaseInsight do
  @moduledoc """
  Provides struct and type for a AgentUseCaseInsight
  """

  @type t :: %__MODULE__{
          runCount: integer | nil,
          topAgentIcon: Gleanex.Client.IconConfig.t() | nil,
          topAgentId: String.t() | nil,
          topAgentIsDeleted: boolean | nil,
          topAgentName: String.t() | nil,
          topDepartments: String.t() | nil,
          trend: number | nil,
          useCase: String.t() | nil
        }

  defstruct [
    :runCount,
    :topAgentIcon,
    :topAgentId,
    :topAgentIsDeleted,
    :topAgentName,
    :topDepartments,
    :trend,
    :useCase
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      runCount: :integer,
      topAgentIcon: {Gleanex.Client.IconConfig, :t},
      topAgentId: :string,
      topAgentIsDeleted: :boolean,
      topAgentName: :string,
      topDepartments: :string,
      trend: {:number, "float"},
      useCase: :string
    ]
  end
end
