defmodule Gleanex.Client.GeneratedQna do
  @moduledoc """
  Provides struct and type for a GeneratedQna
  """

  @type t :: %__MODULE__{
          answer: String.t() | nil,
          cursor: String.t() | nil,
          followUpPrompts: [String.t()] | nil,
          followupActions: [Gleanex.Client.FollowupAction.t()] | nil,
          question: String.t() | nil,
          ranges: [Gleanex.Client.TextRange.t()] | nil,
          status: String.t() | nil,
          trackingToken: String.t() | nil
        }

  defstruct [
    :answer,
    :cursor,
    :followUpPrompts,
    :followupActions,
    :question,
    :ranges,
    :status,
    :trackingToken
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      answer: :string,
      cursor: :string,
      followUpPrompts: [:string],
      followupActions: [{Gleanex.Client.FollowupAction, :t}],
      question: :string,
      ranges: [{Gleanex.Client.TextRange, :t}],
      status:
        {:enum,
         [
           "COMPUTING",
           "DISABLED",
           "FAILED",
           "NO_ANSWER",
           "SKIPPED",
           "STREAMING",
           "SUCCEEDED",
           "TIMEOUT"
         ]},
      trackingToken: :string
    ]
  end
end
