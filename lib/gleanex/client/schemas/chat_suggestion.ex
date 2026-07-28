defmodule Gleanex.Client.ChatSuggestion do
  @moduledoc """
  Provides struct and type for a ChatSuggestion
  """

  @type t :: %__MODULE__{
          cta: String.t() | nil,
          feature: String.t() | nil,
          query: String.t() | nil,
          sourceDocumentIds: [String.t()] | nil
        }

  defstruct [:cta, :feature, :query, :sourceDocumentIds]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [cta: :string, feature: :string, query: :string, sourceDocumentIds: [:string]]
  end
end
