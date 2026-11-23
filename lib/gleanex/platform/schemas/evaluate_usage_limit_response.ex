defmodule Gleanex.Platform.EvaluateUsageLimitResponse do
  @moduledoc """
  Provides struct and type for a EvaluateUsageLimitResponse
  """

  @type t :: %__MODULE__{
          aggregate_usage: Gleanex.Platform.UsageAggregateUsage.t() | nil,
          applicable_policy_count: integer,
          decision: String.t(),
          decision_causes: [Gleanex.Platform.UsageDecisionCause.t()],
          effective_limits: [Gleanex.Platform.UsageHeadroomValue.t()],
          evaluated_at: DateTime.t(),
          evaluated_limits: [Gleanex.Platform.EvaluatedLimit.t()],
          period: Gleanex.Platform.Period.t(),
          request_id: String.t(),
          restrictions: [Gleanex.Platform.UsageRestriction.t()],
          target: Gleanex.Platform.UsageTarget.t(),
          used_by_unit: [Gleanex.Platform.UsageUsedValue.t()] | nil
        }

  defstruct [
    :aggregate_usage,
    :applicable_policy_count,
    :decision,
    :decision_causes,
    :effective_limits,
    :evaluated_at,
    :evaluated_limits,
    :period,
    :request_id,
    :restrictions,
    :target,
    :used_by_unit
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      aggregate_usage: {Gleanex.Platform.UsageAggregateUsage, :t},
      applicable_policy_count: :integer,
      decision: {:enum, ["AVAILABLE", "WARNING", "BLOCKED"]},
      decision_causes: [{Gleanex.Platform.UsageDecisionCause, :t}],
      effective_limits: [{Gleanex.Platform.UsageHeadroomValue, :t}],
      evaluated_at: {:string, "date-time"},
      evaluated_limits: [{Gleanex.Platform.EvaluatedLimit, :t}],
      period: {Gleanex.Platform.Period, :t},
      request_id: :string,
      restrictions: [{Gleanex.Platform.UsageRestriction, :t}],
      target: {Gleanex.Platform.UsageTarget, :t},
      used_by_unit: [{Gleanex.Platform.UsageUsedValue, :t}]
    ]
  end
end
