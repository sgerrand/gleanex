defmodule Gleanex.Platform.EvaluatedLimit do
  @moduledoc """
  Provides struct and type for a EvaluatedLimit
  """

  @type t :: %__MODULE__{
          decision: String.t(),
          target: Gleanex.Platform.UsagePolicySourceTarget.t(),
          usage_selector: Gleanex.Platform.UsageSelector.t(),
          used: String.t(),
          value: Gleanex.Platform.UsageLimitValue.t()
        }

  defstruct [:decision, :target, :usage_selector, :used, :value]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      decision: {:enum, ["AVAILABLE", "WARNING", "BLOCKED"]},
      target: {Gleanex.Platform.UsagePolicySourceTarget, :t},
      usage_selector: {Gleanex.Platform.UsageSelector, :t},
      used: :string,
      value: {Gleanex.Platform.UsageLimitValue, :t}
    ]
  end
end
