defmodule Gleanex.Client.ChatSuggestion do
  @moduledoc """
  Provides struct and type for a ChatSuggestion
  """

  @type t :: %__MODULE__{
          artifactType: String.t() | nil,
          cta: String.t() | nil,
          feature: String.t() | nil,
          query: String.t() | nil,
          sourceDocumentIds: [String.t()] | nil
        }

  defstruct [:artifactType, :cta, :feature, :query, :sourceDocumentIds]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      artifactType: {:enum, ["PAPER", "AGENT", "MESSAGE", "EMAIL", "HTML_CODE", "SLIDE"]},
      cta: :string,
      feature: :string,
      query: :string,
      sourceDocumentIds: [:string]
    ]
  end
end
