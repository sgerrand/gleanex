defmodule Gleanex.Platform.AgentTrigger do
  @moduledoc """
  Provides struct and type for a AgentTrigger
  """

  @type t :: %__MODULE__{
          content: Gleanex.Platform.AgentTriggerContent.t() | nil,
          input_fields: [Gleanex.Platform.AgentInputField.t()] | nil,
          prompts: [Gleanex.Platform.AgentPrompt.t()] | nil,
          schedule: Gleanex.Platform.AgentSchedule.t() | nil,
          type: String.t()
        }

  defstruct [:content, :input_fields, :prompts, :schedule, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      content: {Gleanex.Platform.AgentTriggerContent, :t},
      input_fields: [{Gleanex.Platform.AgentInputField, :t}],
      prompts: [{Gleanex.Platform.AgentPrompt, :t}],
      schedule: {Gleanex.Platform.AgentSchedule, :t},
      type: {:enum, ["CHAT_MESSAGE", "INPUT_FORM", "CONTENT_TRIGGER"]}
    ]
  end
end
