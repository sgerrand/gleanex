defmodule Gleanex.Platform.SkillUpdateResponse do
  @moduledoc """
  Provides struct and type for a SkillUpdateResponse
  """

  @type t :: %__MODULE__{request_id: String.t(), skill: Gleanex.Platform.Skill.t()}

  defstruct [:request_id, :skill]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [request_id: :string, skill: {Gleanex.Platform.Skill, :t}]
  end
end
