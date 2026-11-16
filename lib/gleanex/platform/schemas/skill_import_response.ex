defmodule Gleanex.Platform.SkillImportResponse do
  @moduledoc """
  Provides struct and type for a SkillImportResponse
  """

  @type t :: %__MODULE__{request_id: String.t(), skills: [Gleanex.Platform.Skill.t()]}

  defstruct [:request_id, :skills]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [request_id: :string, skills: [{Gleanex.Platform.Skill, :t}]]
  end
end
