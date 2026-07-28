defmodule Gleanex.Client.FeedbackChatExchangeResultDocuments do
  @moduledoc """
  Provides struct and type for a FeedbackChatExchangeResultDocuments
  """

  @type t :: %__MODULE__{title: String.t() | nil, url: String.t() | nil}

  defstruct [:title, :url]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [title: :string, url: :string]
  end
end
