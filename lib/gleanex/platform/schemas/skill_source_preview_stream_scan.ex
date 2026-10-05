defmodule Gleanex.Platform.SkillSourcePreviewStreamScan do
  @moduledoc """
  Provides struct and type for a SkillSourcePreviewStreamScan
  """

  @type t :: %__MODULE__{skill_paths: [String.t()], total: integer, type: String.t()}

  defstruct [:skill_paths, :total, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [skill_paths: [:string], total: :integer, type: {:const, "SCAN"}]
  end
end
