defmodule Gleanex.Client.FeedbackChatExchange do
  @moduledoc """
  Provides struct and type for a FeedbackChatExchange
  """

  @type t :: %__MODULE__{
          agent: String.t() | nil,
          response: String.t() | nil,
          resultDocuments: [Gleanex.Client.FeedbackChatExchangeResultDocuments.t()] | nil,
          searchQuery: String.t() | nil,
          timestamp: integer | nil,
          userQuery: String.t() | nil
        }

  defstruct [:agent, :response, :resultDocuments, :searchQuery, :timestamp, :userQuery]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      agent: :string,
      response: :string,
      resultDocuments: [{Gleanex.Client.FeedbackChatExchangeResultDocuments, :t}],
      searchQuery: :string,
      timestamp: {:integer, "int64"},
      userQuery: :string
    ]
  end
end
