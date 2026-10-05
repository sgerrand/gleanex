defmodule Gleanex.Platform.SkillSourcePreviewStreamResult do
  @moduledoc """
  Provides struct and type for a SkillSourcePreviewStreamResult
  """

  @type t :: %__MODULE__{
          response: Gleanex.Platform.SkillSourcePreviewResponse.t(),
          type: String.t()
        }

  defstruct [:response, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [response: {Gleanex.Platform.SkillSourcePreviewResponse, :t}, type: {:const, "RESULT"}]
  end
end
