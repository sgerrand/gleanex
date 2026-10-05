defmodule Gleanex.Platform.EvaluateUsageLimitResponse do
  @moduledoc """
  Provides struct and type for a EvaluateUsageLimitResponse
  """

  @type t :: %__MODULE__{
          decision: String.t(),
          effective_limits: [Gleanex.Platform.UsageLimitValue.t()],
          evaluated_at: DateTime.t(),
          evaluated_limits: [Gleanex.Platform.EvaluatedLimit.t()],
          request_id: String.t()
        }

  defstruct [:decision, :effective_limits, :evaluated_at, :evaluated_limits, :request_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      decision: {:enum, ["AVAILABLE", "WARNING", "BLOCKED"]},
      effective_limits: [{Gleanex.Platform.UsageLimitValue, :t}],
      evaluated_at: {:string, "date-time"},
      evaluated_limits: [{Gleanex.Platform.EvaluatedLimit, :t}],
      request_id: :string
    ]
  end
end
