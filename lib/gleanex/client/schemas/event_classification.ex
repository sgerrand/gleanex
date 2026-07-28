defmodule Gleanex.Client.EventClassification do
  @moduledoc """
  Provides struct and type for a EventClassification
  """

  @type t :: %__MODULE__{name: String.t() | nil, strategies: [String.t()] | nil}

  defstruct [:name, :strategies]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      name: {:const, "External Event"},
      strategies: [
        enum: [
          "customerCard",
          "news",
          "call",
          "email",
          "meetingNotes",
          "linkedIn",
          "relevantDocuments",
          "chatFollowUps",
          "conversations"
        ]
      ]
    ]
  end
end
