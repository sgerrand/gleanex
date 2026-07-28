defmodule Gleanex.Client.ManualFeedbackInfo do
  @moduledoc """
  Provides struct and type for a ManualFeedbackInfo
  """

  @type t :: %__MODULE__{
          activeTab: String.t() | nil,
          chatTranscript: [Gleanex.Client.FeedbackChatExchange.t()] | nil,
          comments: String.t() | nil,
          email: String.t() | nil,
          imageUrls: [String.t()] | nil,
          issue: String.t() | nil,
          issues: [String.t()] | nil,
          numQueriesFromFirstRun: integer | nil,
          obscuredQuery: String.t() | nil,
          previousMessages: [String.t()] | nil,
          query: String.t() | nil,
          rating: integer | nil,
          ratingKey: String.t() | nil,
          ratingScale: integer | nil,
          searchResults: [String.t()] | nil,
          source: String.t() | nil,
          vote: String.t() | nil
        }

  defstruct [
    :activeTab,
    :chatTranscript,
    :comments,
    :email,
    :imageUrls,
    :issue,
    :issues,
    :numQueriesFromFirstRun,
    :obscuredQuery,
    :previousMessages,
    :query,
    :rating,
    :ratingKey,
    :ratingScale,
    :searchResults,
    :source,
    :vote
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      activeTab: :string,
      chatTranscript: [{Gleanex.Client.FeedbackChatExchange, :t}],
      comments: :string,
      email: :string,
      imageUrls: [:string],
      issue: :string,
      issues: [
        enum: [
          "AGENT_CANVAS_FAILED",
          "AGENT_CLARIFYING_QUESTIONS",
          "AGENT_INTERMEDIATE_STEPS_FAILED",
          "AGENT_TOOL_CALL_FAILED",
          "INACCURATE_RESPONSE",
          "INCOMPLETE_OR_NO_ANSWER",
          "INCORRECT_CITATION",
          "MISSING_CITATION",
          "OTHER",
          "OUTDATED_RESPONSE",
          "RESULT_MISSING",
          "RESULT_SHOULD_NOT_APPEAR",
          "RESULTS_HELPFUL",
          "RESULTS_POOR_ORDER",
          "TOO_MUCH_ONE_KIND",
          "NOT_A_QUESTION",
          "UNSURE_IF_CORRECT"
        ]
      ],
      numQueriesFromFirstRun: :integer,
      obscuredQuery: :string,
      previousMessages: [:string],
      query: :string,
      rating: :integer,
      ratingKey: :string,
      ratingScale: :integer,
      searchResults: [:string],
      source:
        {:enum,
         [
           "AUTOCOMPLETE",
           "CALENDAR",
           "CHAT",
           "CHAT_GENERAL",
           "CONCEPT_CARD",
           "DESKTOP_APP",
           "DISAMBIGUATION_CARD",
           "EXPERT_DETECTION",
           "FEED",
           "GENERATED_Q_AND_A",
           "INLINE_MENU",
           "NATIVE_RESULT",
           "PRISM",
           "Q_AND_A",
           "RELATED_QUESTIONS",
           "REPORT_ISSUE",
           "SCIOBOT",
           "SEARCH",
           "SIDEBAR",
           "SUMMARY",
           "TASKS",
           "TASK_EXECUTION"
         ]},
      vote: {:enum, ["UPVOTE", "DOWNVOTE"]}
    ]
  end
end
