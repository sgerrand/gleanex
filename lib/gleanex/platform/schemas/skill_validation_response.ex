defmodule Gleanex.Platform.SkillValidationResponse do
  @moduledoc """
  Provides struct and type for a SkillValidationResponse
  """

  @type t :: %__MODULE__{
          files: [Gleanex.Platform.SkillValidationFile.t()],
          metadata: Gleanex.Platform.SkillValidationMetadata.t(),
          request_id: String.t(),
          warnings: [Gleanex.Platform.PlatformWarning.t()]
        }

  defstruct [:files, :metadata, :request_id, :warnings]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      files: [{Gleanex.Platform.SkillValidationFile, :t}],
      metadata: {Gleanex.Platform.SkillValidationMetadata, :t},
      request_id: :string,
      warnings: [{Gleanex.Platform.PlatformWarning, :t}]
    ]
  end
end
