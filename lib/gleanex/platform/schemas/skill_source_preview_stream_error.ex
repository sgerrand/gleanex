defmodule Gleanex.Platform.SkillSourcePreviewStreamError do
  @moduledoc """
  Provides struct and type for a SkillSourcePreviewStreamError
  """

  @type t :: %__MODULE__{
          authentication_suggestions: [Gleanex.Platform.AuthenticationSuggestion.t()] | nil,
          error: Gleanex.Platform.ProblemDetail.t(),
          type: String.t()
        }

  defstruct [:authentication_suggestions, :error, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      authentication_suggestions: [{Gleanex.Platform.AuthenticationSuggestion, :t}],
      error: {Gleanex.Platform.ProblemDetail, :t},
      type: {:const, "ERROR"}
    ]
  end
end
