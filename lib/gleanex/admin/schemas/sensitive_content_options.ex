defmodule Gleanex.Admin.SensitiveContentOptions do
  @moduledoc """
  Provides struct and type for a SensitiveContentOptions
  """

  @type t :: %__MODULE__{
          customSensitiveExpressions: [Gleanex.Admin.CustomSensitiveExpression.t()] | nil,
          sensitiveInfoTypes: [Gleanex.Admin.SensitiveInfoType.t()] | nil,
          sensitiveRegexes: [Gleanex.Admin.SensitiveExpression.t()] | nil,
          sensitiveTerms: [Gleanex.Admin.SensitiveExpression.t()] | nil
        }

  defstruct [:customSensitiveExpressions, :sensitiveInfoTypes, :sensitiveRegexes, :sensitiveTerms]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      customSensitiveExpressions: [{Gleanex.Admin.CustomSensitiveExpression, :t}],
      sensitiveInfoTypes: [{Gleanex.Admin.SensitiveInfoType, :t}],
      sensitiveRegexes: [{Gleanex.Admin.SensitiveExpression, :t}],
      sensitiveTerms: [{Gleanex.Admin.SensitiveExpression, :t}]
    ]
  end
end
