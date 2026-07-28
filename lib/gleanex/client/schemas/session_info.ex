defmodule Gleanex.Client.SessionInfo do
  @moduledoc """
  Provides struct and type for a SessionInfo
  """

  @type t :: %__MODULE__{
          lastQuery: String.t() | nil,
          lastSeen: DateTime.t() | nil,
          sessionTrackingToken: String.t() | nil,
          tabId: String.t() | nil
        }

  defstruct [:lastQuery, :lastSeen, :sessionTrackingToken, :tabId]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      lastQuery: :string,
      lastSeen: {:string, "date-time"},
      sessionTrackingToken: :string,
      tabId: :string
    ]
  end
end
