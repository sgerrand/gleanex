defmodule Gleanex.Platform.SkillValidationMetadata do
  @moduledoc """
  Provides struct and type for a SkillValidationMetadata
  """

  @type t :: %__MODULE__{description: String.t(), display_name: String.t()}

  defstruct [:description, :display_name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [description: :string, display_name: :string]
  end
end
