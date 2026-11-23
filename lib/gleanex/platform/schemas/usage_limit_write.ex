defmodule Gleanex.Platform.UsageLimitWrite do
  @moduledoc """
  Provides struct and type for a UsageLimitWrite
  """

  @type t :: %__MODULE__{
          actions: [Gleanex.Platform.UsageLimitWriteActions.t()] | nil,
          allocation_mode: String.t() | nil,
          period: Gleanex.Platform.Period.t() | nil,
          target: Gleanex.Platform.UsageTarget.t() | nil,
          value: Gleanex.Platform.UsageLimitValue.t() | nil
        }

  defstruct [:actions, :allocation_mode, :period, :target, :value]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      actions: [{Gleanex.Platform.UsageLimitWriteActions, :t}],
      allocation_mode: {:enum, ["SHARED_POOL", "PER_MEMBER"]},
      period: {Gleanex.Platform.Period, :t},
      target: {Gleanex.Platform.UsageTarget, :t},
      value: {Gleanex.Platform.UsageLimitValue, :t}
    ]
  end
end
