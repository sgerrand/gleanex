defmodule Gleanex.Client.FeedResult do
  @moduledoc """
  Provides struct and type for a FeedResult
  """

  @type t :: %__MODULE__{
          category: String.t(),
          placementReason: String.t() | nil,
          primaryEntry: Gleanex.Client.FeedEntry.t(),
          rank: integer | nil,
          secondaryEntries: [Gleanex.Client.FeedEntry.t()] | nil
        }

  defstruct [:category, :placementReason, :primaryEntry, :rank, :secondaryEntries]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      category:
        {:enum,
         [
           "DOCUMENT_SUGGESTION",
           "DOCUMENT_SUGGESTION_SCENARIO",
           "TRENDING_DOCUMENT",
           "USE_CASE",
           "VERIFICATION_REMINDER",
           "EVENT",
           "ANNOUNCEMENT",
           "MENTION",
           "DATASOURCE_AFFINITY",
           "RECENT",
           "COMPANY_RESOURCE",
           "EXPERIMENTAL",
           "PEOPLE_CELEBRATIONS",
           "SOCIAL_LINK",
           "EXTERNAL_TASKS",
           "DISPLAYABLE_LIST",
           "ZERO_STATE_CHAT_SUGGESTION",
           "ZERO_STATE_CHAT_TOOL_SUGGESTION",
           "ZERO_STATE_WORKFLOW_CREATED_BY_ME",
           "ZERO_STATE_WORKFLOW_FAVORITES",
           "ZERO_STATE_WORKFLOW_POPULAR",
           "ZERO_STATE_WORKFLOW_RECENT",
           "ZERO_STATE_WORKFLOW_SUGGESTION",
           "PERSONALIZED_CHAT_SUGGESTION",
           "DAILY_DIGEST",
           "PODCAST",
           "TASK",
           "PLAN_MY_DAY",
           "END_MY_DAY",
           "STARTER_KIT",
           "MID_DAY_CATCH_UP",
           "QUERY_SUGGESTION",
           "COWORK_CUJ_PROMO",
           "CARD_STACK_PROMO",
           "WEEKLY_MEETINGS",
           "FOLLOW_UP",
           "MILESTONE_TIMELINE_CHECK",
           "PROJECT_DISCUSSION_DIGEST",
           "PROJECT_FOCUS_BLOCK",
           "PROJECT_NEXT_STEP",
           "DEMO_CARD",
           "OOO_PLANNER",
           "OOO_CATCH_UP",
           "ADMIN_HEALTH_CENTER"
         ]},
      placementReason: {:enum, ["ORGANIC", "PROMO"]},
      primaryEntry: {Gleanex.Client.FeedEntry, :t},
      rank: :integer,
      secondaryEntries: [{Gleanex.Client.FeedEntry, :t}]
    ]
  end
end
