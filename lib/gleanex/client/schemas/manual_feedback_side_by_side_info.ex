defmodule Gleanex.Client.ManualFeedbackSideBySideInfo do
  @moduledoc """
  Provides struct and type for a ManualFeedbackSideBySideInfo
  """

  @type t :: %__MODULE__{
          comments: String.t() | nil,
          email: String.t() | nil,
          evaluationSessionId: String.t() | nil,
          implementationId: String.t() | nil,
          implementations: [Gleanex.Client.SideBySideImplementation.t()] | nil,
          query: String.t() | nil,
          source: String.t() | nil,
          vote: String.t() | nil
        }

  defstruct [
    :comments,
    :email,
    :evaluationSessionId,
    :implementationId,
    :implementations,
    :query,
    :source,
    :vote
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      comments: :string,
      email: :string,
      evaluationSessionId: :string,
      implementationId: :string,
      implementations: [{Gleanex.Client.SideBySideImplementation, :t}],
      query: :string,
      source: {:enum, ["LIVE_EVAL", "CHAT", "SEARCH"]},
      vote: {:enum, ["UPVOTE", "DOWNVOTE", "NEUTRAL"]}
    ]
  end
end
