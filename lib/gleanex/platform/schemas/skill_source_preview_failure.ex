defmodule Gleanex.Platform.SkillSourcePreviewFailure do
  @moduledoc """
  Provides struct and type for a SkillSourcePreviewFailure
  """

  @type t :: %__MODULE__{code: String.t(), detail: String.t(), source_url: String.t()}

  defstruct [:code, :detail, :source_url]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [code: {:enum, ["INVALID_SKILL", "SKILL_FETCH_FAILED"]}, detail: :string, source_url: :string]
  end
end
