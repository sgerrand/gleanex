defmodule Gleanex.Platform.SkillSourcePreviewResponse do
  @moduledoc """
  Provides struct and type for a SkillSourcePreviewResponse
  """

  @type t :: %__MODULE__{
          failures: [Gleanex.Platform.SkillSourcePreviewFailure.t()],
          request_id: String.t(),
          skills: [Gleanex.Platform.SkillSourcePreview.t()]
        }

  defstruct [:failures, :request_id, :skills]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      failures: [{Gleanex.Platform.SkillSourcePreviewFailure, :t}],
      request_id: :string,
      skills: [{Gleanex.Platform.SkillSourcePreview, :t}]
    ]
  end
end
