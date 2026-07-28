defmodule Gleanex.Client.FavoriteInfo do
  @moduledoc """
  Provides struct and type for a FavoriteInfo
  """

  @type t :: %__MODULE__{
          count: integer | nil,
          favoritedByUser: boolean | nil,
          id: String.t() | nil,
          ugcType: String.t() | nil
        }

  defstruct [:count, :favoritedByUser, :id, :ugcType]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      count: :integer,
      favoritedByUser: :boolean,
      id: :string,
      ugcType:
        {:enum,
         [
           "AGENT_TYPE",
           "ANNOUNCEMENTS_TYPE",
           "ANSWERS_TYPE",
           "CHATS_TYPE",
           "COLLECTIONS_TYPE",
           "EMAIL_TYPE",
           "HTML_CODE_TYPE",
           "IMAGE_TYPE",
           "MESSAGE_TYPE",
           "PAPER_TYPE",
           "PRISM_VIEWS_TYPE",
           "PROMPT_TEMPLATES_TYPE",
           "PINS_TYPE",
           "SCRIBES_TYPE",
           "SHORTCUTS_TYPE",
           "SLIDE_TYPE",
           "SPREADSHEET_TYPE",
           "INLINE_HTML_TYPE",
           "PODCAST_TYPE",
           "WORKFLOWS_TYPE"
         ]}
    ]
  end
end
