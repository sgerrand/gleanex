defmodule Gleanex.Platform.UsageDecisionCause do
  @moduledoc """
  Provides struct and type for a UsageDecisionCause
  """

  @type t :: %__MODULE__{budget_scope: String.t(), decision: String.t(), source_type: String.t()}

  defstruct [:budget_scope, :decision, :source_type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      budget_scope: {:enum, ["TARGET", "SHARED"]},
      decision: {:enum, ["AVAILABLE", "WARNING", "BLOCKED"]},
      source_type:
        {:enum,
         [
           "ORGANIZATION",
           "DEFAULT_USER",
           "DEFAULT_AGENT",
           "USER",
           "AGENT",
           "IDP_GROUP",
           "DEPARTMENT"
         ]}
    ]
  end
end
