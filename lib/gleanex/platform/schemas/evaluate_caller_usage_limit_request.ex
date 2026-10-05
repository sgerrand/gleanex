defmodule Gleanex.Platform.EvaluateCallerUsageLimitRequest do
  @moduledoc """
  Provides struct and type for a EvaluateCallerUsageLimitRequest
  """

  @type t :: %__MODULE__{usage_selector: map}

  defstruct [:usage_selector]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [usage_selector: :map]
  end
end
