defmodule Gleanex.Platform.AgentSkill do
  @moduledoc """
  Provides struct and type for a AgentSkill
  """

  @type t :: %__MODULE__{
          display_name: String.t(),
          files: [Gleanex.Platform.SkillSourcePreviewFile.t()] | nil,
          main_content: String.t()
        }

  defstruct [:display_name, :files, :main_content]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      display_name: :string,
      files: [{Gleanex.Platform.SkillSourcePreviewFile, :t}],
      main_content: :string
    ]
  end
end
