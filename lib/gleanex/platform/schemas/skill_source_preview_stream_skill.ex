defmodule Gleanex.Platform.SkillSourcePreviewStreamSkill do
  @moduledoc """
  Provides struct and type for a SkillSourcePreviewStreamSkill
  """

  @type t :: %__MODULE__{skill: Gleanex.Platform.SkillSourcePreview.t(), type: String.t()}

  defstruct [:skill, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [skill: {Gleanex.Platform.SkillSourcePreview, :t}, type: {:const, "SKILL"}]
  end
end
