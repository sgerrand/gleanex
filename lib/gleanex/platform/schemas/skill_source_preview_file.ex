defmodule Gleanex.Platform.SkillSourcePreviewFile do
  @moduledoc """
  Provides struct and type for a SkillSourcePreviewFile
  """

  @type t :: %__MODULE__{content: String.t(), path: String.t()}

  defstruct [:content, :path]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [content: :string, path: :string]
  end
end
