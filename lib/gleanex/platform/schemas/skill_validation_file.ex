defmodule Gleanex.Platform.SkillValidationFile do
  @moduledoc """
  Provides struct and type for a SkillValidationFile
  """

  @type t :: %__MODULE__{is_manifest: boolean, path: String.t(), size_bytes: integer}

  defstruct [:is_manifest, :path, :size_bytes]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [is_manifest: :boolean, path: :string, size_bytes: :integer]
  end
end
