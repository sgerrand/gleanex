defmodule Gleanex.Platform.EvaluateUsageLimitRequest do
  @moduledoc """
  Provides struct and type for a EvaluateUsageLimitRequest
  """

  @type t :: %__MODULE__{
          target: Gleanex.Platform.EvaluateUsageLimitRequestTarget.t(),
          usage_selector: map
        }

  defstruct [:target, :usage_selector]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [target: {Gleanex.Platform.EvaluateUsageLimitRequestTarget, :t}, usage_selector: :map]
  end
end
