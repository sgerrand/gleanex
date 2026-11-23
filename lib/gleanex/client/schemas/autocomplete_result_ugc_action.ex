defmodule Gleanex.Client.AutocompleteResultUgcAction do
  @moduledoc """
  Provides struct and type for a AutocompleteResultUgcAction
  """

  @type t :: %__MODULE__{create: String.t()}

  defstruct [:create]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      create:
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
           "SKILLS_TYPE",
           "SLIDE_TYPE",
           "SPREADSHEET_TYPE",
           "INLINE_HTML_TYPE",
           "PODCAST_TYPE",
           "VIDEO_TYPE",
           "WORKFLOWS_TYPE"
         ]}
    ]
  end
end
