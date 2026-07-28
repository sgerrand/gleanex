defmodule Gleanex.Client.PerAgentInsight do
  @moduledoc """
  Provides struct and type for a PerAgentInsight
  """

  @type t :: %__MODULE__{
          agentId: String.t() | nil,
          agentName: String.t() | nil,
          downvoteCount: integer | nil,
          icon: Gleanex.Client.IconConfig.t() | nil,
          isDeleted: boolean | nil,
          owner: Gleanex.Client.Person.t() | nil,
          runCount: integer | nil,
          upvoteCount: integer | nil,
          userCount: integer | nil
        }

  defstruct [
    :agentId,
    :agentName,
    :downvoteCount,
    :icon,
    :isDeleted,
    :owner,
    :runCount,
    :upvoteCount,
    :userCount
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      agentId: :string,
      agentName: :string,
      downvoteCount: :integer,
      icon: {Gleanex.Client.IconConfig, :t},
      isDeleted: :boolean,
      owner: {Gleanex.Client.Person, :t},
      runCount: :integer,
      upvoteCount: :integer,
      userCount: :integer
    ]
  end
end
