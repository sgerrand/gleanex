defmodule Gleanex.Client.MessagesResponse do
  @moduledoc """
  Provides struct and type for a MessagesResponse
  """

  @type t :: %__MODULE__{
          hasMore: boolean,
          rootMessage: Gleanex.Client.SearchResult.t() | nil,
          searchResponse: Gleanex.Client.SearchResponse.t() | nil
        }

  defstruct [:hasMore, :rootMessage, :searchResponse]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      hasMore: :boolean,
      rootMessage: {Gleanex.Client.SearchResult, :t},
      searchResponse: {Gleanex.Client.SearchResponse, :t}
    ]
  end
end
