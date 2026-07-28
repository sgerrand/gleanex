defmodule Gleanex.Client.AnnouncementViewerInfo do
  @moduledoc """
  Provides struct and type for a AnnouncementViewerInfo
  """

  @type t :: %__MODULE__{isDismissed: boolean | nil, isRead: boolean | nil}

  defstruct [:isDismissed, :isRead]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [isDismissed: :boolean, isRead: :boolean]
  end
end
