defmodule Gleanex.Client.IndexStatus do
  @moduledoc """
  Provides struct and type for a IndexStatus
  """

  @type t :: %__MODULE__{lastCrawledTime: DateTime.t() | nil, lastIndexedTime: DateTime.t() | nil}

  defstruct [:lastCrawledTime, :lastIndexedTime]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [lastCrawledTime: {:string, "date-time"}, lastIndexedTime: {:string, "date-time"}]
  end
end
