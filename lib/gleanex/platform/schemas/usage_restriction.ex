defmodule Gleanex.Platform.UsageRestriction do
  @moduledoc """
  Provides struct and type for a UsageRestriction
  """

  @type t :: %__MODULE__{
          allow: Gleanex.Platform.UsageModelFilter.t(),
          source: Gleanex.Platform.UsagePolicySourceTarget.t(),
          type: String.t()
        }

  defstruct [:allow, :source, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      allow: {Gleanex.Platform.UsageModelFilter, :t},
      source: {Gleanex.Platform.UsagePolicySourceTarget, :t},
      type: {:enum, ["NOTIFY", "RESTRICT_MODELS", "BLOCK"]}
    ]
  end
end
