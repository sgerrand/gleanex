defmodule Gleanex.Admin.CustomSensitiveExpression do
  @moduledoc """
  Provides struct and type for a CustomSensitiveExpression
  """

  @type t :: %__MODULE__{
          evaluationExpression: String.t() | nil,
          id: String.t() | nil,
          keyword: Gleanex.Admin.CustomSensitiveRule.t() | nil
        }

  defstruct [:evaluationExpression, :id, :keyword]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [evaluationExpression: :string, id: :string, keyword: {Gleanex.Admin.CustomSensitiveRule, :t}]
  end
end
