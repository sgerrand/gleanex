defmodule Gleanex.Platform.EvaluatedUsageLimitAction do
  @moduledoc """
  Provides struct and type for a EvaluatedUsageLimitAction
  """

  @type t :: %__MODULE__{
          allow: Gleanex.Platform.UsageModelFilter.t() | nil,
          at_percent: number,
          inherited_from: Gleanex.Platform.UsagePolicySourceTarget.t() | nil,
          type: String.t()
        }

  defstruct [:allow, :at_percent, :inherited_from, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      allow: {Gleanex.Platform.UsageModelFilter, :t},
      at_percent: {:number, "float"},
      inherited_from: {Gleanex.Platform.UsagePolicySourceTarget, :t},
      type: {:enum, ["NOTIFY", "RESTRICT_MODELS", "BLOCK"]}
    ]
  end
end
