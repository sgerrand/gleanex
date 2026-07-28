defmodule Gleanex.Client.Feedback do
  @moduledoc """
  Provides struct and type for a Feedback
  """

  @type t :: %__MODULE__{
          agentId: String.t() | nil,
          applicationId: String.t() | nil,
          category: String.t() | nil,
          channels: [String.t()] | nil,
          event: String.t(),
          id: String.t() | nil,
          manualFeedbackInfo: Gleanex.Client.ManualFeedbackInfo.t() | nil,
          manualFeedbackSideBySideInfo: Gleanex.Client.ManualFeedbackSideBySideInfo.t() | nil,
          pathname: String.t() | nil,
          payload: String.t() | nil,
          position: integer | nil,
          seenFeedbackInfo: Gleanex.Client.SeenFeedbackInfo.t() | nil,
          sessionInfo: Gleanex.Client.SessionInfo.t() | nil,
          timestamp: DateTime.t() | nil,
          trackingTokens: [String.t()],
          uiElement: String.t() | nil,
          uiTree: [String.t()] | nil,
          url: String.t() | nil,
          user: Gleanex.Client.User.t() | nil,
          userViewInfo: Gleanex.Client.UserViewInfo.t() | nil,
          workflowFeedbackInfo: Gleanex.Client.WorkflowFeedbackInfo.t() | nil
        }

  defstruct [
    :agentId,
    :applicationId,
    :category,
    :channels,
    :event,
    :id,
    :manualFeedbackInfo,
    :manualFeedbackSideBySideInfo,
    :pathname,
    :payload,
    :position,
    :seenFeedbackInfo,
    :sessionInfo,
    :timestamp,
    :trackingTokens,
    :uiElement,
    :uiTree,
    :url,
    :user,
    :userViewInfo,
    :workflowFeedbackInfo
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      agentId: :string,
      applicationId: :string,
      category:
        {:enum,
         [
           "ANNOUNCEMENT",
           "ANSWERS",
           "ARTIFACTS",
           "AUTOCOMPLETE",
           "COLLECTIONS",
           "FEED",
           "SEARCH",
           "CHAT",
           "NTP",
           "WORKFLOWS",
           "SUMMARY",
           "GENERAL",
           "PRISM",
           "PROMPTS"
         ]},
      channels: [enum: ["COMPANY", "GLEAN"]],
      event:
        {:enum,
         [
           "CLICK",
           "CONTAINER_CLICK",
           "COPY_LINK",
           "CREATE",
           "DISMISS",
           "DOWNVOTE",
           "EMAIL",
           "EXECUTE",
           "FILTER",
           "FIRST_TOKEN",
           "FOCUS_IN",
           "LAST_TOKEN",
           "MANUAL_FEEDBACK",
           "MANUAL_FEEDBACK_SIDE_BY_SIDE",
           "FEEDBACK_TIME_SAVED",
           "MARK_AS_READ",
           "MESSAGE",
           "MIDDLE_CLICK",
           "PAGE_BLUR",
           "PAGE_FOCUS",
           "PAGE_LEAVE",
           "PREVIEW",
           "RELATED_CLICK",
           "RIGHT_CLICK",
           "SECTION_CLICK",
           "SEEN",
           "SELECT",
           "SHARE",
           "SHOW_MORE",
           "UPVOTE",
           "VIEW",
           "VISIBLE"
         ]},
      id: :string,
      manualFeedbackInfo: {Gleanex.Client.ManualFeedbackInfo, :t},
      manualFeedbackSideBySideInfo: {Gleanex.Client.ManualFeedbackSideBySideInfo, :t},
      pathname: :string,
      payload: :string,
      position: :integer,
      seenFeedbackInfo: {Gleanex.Client.SeenFeedbackInfo, :t},
      sessionInfo: {Gleanex.Client.SessionInfo, :t},
      timestamp: {:string, "date-time"},
      trackingTokens: [:string],
      uiElement: :string,
      uiTree: [:string],
      url: :string,
      user: {Gleanex.Client.User, :t},
      userViewInfo: {Gleanex.Client.UserViewInfo, :t},
      workflowFeedbackInfo: {Gleanex.Client.WorkflowFeedbackInfo, :t}
    ]
  end
end
