defmodule Gleanex.Client.ActivityEvent do
  @moduledoc """
  Provides struct and type for a ActivityEvent
  """

  @type t :: %__MODULE__{
          action: String.t(),
          id: String.t() | nil,
          params: Gleanex.Client.ActivityEventParams.t() | nil,
          timestamp: DateTime.t(),
          url: String.t()
        }

  defstruct [:action, :id, :params, :timestamp, :url]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      action:
        {:enum,
         ["VIEW", "EDIT", "SEARCH", "COMMENT", "CRAWL", "HISTORICAL_SEARCH", "HISTORICAL_VIEW"]},
      id: :string,
      params: {Gleanex.Client.ActivityEventParams, :t},
      timestamp: {:string, "date-time"},
      url: :string
    ]
  end
end
