defmodule Gleanex.Platform.SkillSourcePreviewStreamProgress do
  @moduledoc """
  Provides struct and type for a SkillSourcePreviewStreamProgress
  """

  @type t :: %__MODULE__{
          completed: integer,
          current_skill: String.t(),
          total: integer,
          type: String.t()
        }

  defstruct [:completed, :current_skill, :total, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [completed: :integer, current_skill: :string, total: :integer, type: {:const, "PROGRESS"}]
  end
end
