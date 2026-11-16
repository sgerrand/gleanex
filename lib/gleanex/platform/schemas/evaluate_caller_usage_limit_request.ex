defmodule Gleanex.Platform.EvaluateCallerUsageLimitRequest do
  @moduledoc """
  Provides struct and type for a EvaluateCallerUsageLimitRequest
  """

  @type t :: %__MODULE__{target: Gleanex.Platform.EvaluateCallerUsageLimitRequestTarget.t() | nil}

  defstruct [:target]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [target: {Gleanex.Platform.EvaluateCallerUsageLimitRequestTarget, :t}]
  end
end
