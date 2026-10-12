defmodule Gleanex.Platform.EvaluateUsageLimitResponse do
  @moduledoc """
  Provides struct and type for a EvaluateUsageLimitResponse
  """

  @type t :: %__MODULE__{
          applicable_policy_count: integer,
          decision: String.t(),
          effective_limits: [Gleanex.Platform.UsageHeadroomValue.t()],
          evaluated_at: DateTime.t(),
          evaluated_limits: [Gleanex.Platform.EvaluatedLimit.t()],
          request_id: String.t(),
          target: Gleanex.Platform.UsageTarget.t(),
          usage_selector: Gleanex.Platform.UsageSelector.t()
        }

  defstruct [
    :applicable_policy_count,
    :decision,
    :effective_limits,
    :evaluated_at,
    :evaluated_limits,
    :request_id,
    :target,
    :usage_selector
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      applicable_policy_count: :integer,
      decision: {:enum, ["AVAILABLE", "WARNING", "BLOCKED"]},
      effective_limits: [{Gleanex.Platform.UsageHeadroomValue, :t}],
      evaluated_at: {:string, "date-time"},
      evaluated_limits: [{Gleanex.Platform.EvaluatedLimit, :t}],
      request_id: :string,
      target: {Gleanex.Platform.UsageTarget, :t},
      usage_selector: {Gleanex.Platform.UsageSelector, :t}
    ]
  end
end
