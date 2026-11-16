defmodule Gleanex.Platform.EvaluatedLimit do
  @moduledoc """
  Provides struct and type for a EvaluatedLimit
  """

  @type t :: %__MODULE__{
          active_actions: [Gleanex.Platform.EvaluatedUsageLimitAction.t()],
          decision: String.t(),
          next_action: Gleanex.Platform.EvaluatedUsageLimitAction.t() | nil,
          period: Gleanex.Platform.Period.t(),
          target: Gleanex.Platform.UsagePolicySourceTarget.t(),
          used: String.t(),
          value: Gleanex.Platform.UsageLimitValue.t()
        }

  defstruct [:active_actions, :decision, :next_action, :period, :target, :used, :value]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      active_actions: [{Gleanex.Platform.EvaluatedUsageLimitAction, :t}],
      decision: {:enum, ["AVAILABLE", "WARNING", "BLOCKED"]},
      next_action: {Gleanex.Platform.EvaluatedUsageLimitAction, :t},
      period: {Gleanex.Platform.Period, :t},
      target: {Gleanex.Platform.UsagePolicySourceTarget, :t},
      used: :string,
      value: {Gleanex.Platform.UsageLimitValue, :t}
    ]
  end
end
