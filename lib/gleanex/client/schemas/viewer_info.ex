defmodule Gleanex.Client.ViewerInfo do
  @moduledoc """
  Provides struct and type for a ViewerInfo
  """

  @type t :: %__MODULE__{lastViewedTime: DateTime.t() | nil, role: String.t() | nil}

  defstruct [:lastViewedTime, :role]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      lastViewedTime: {:string, "date-time"},
      role: {:enum, ["ANSWER_MODERATOR", "OWNER", "VIEWER"]}
    ]
  end
end
