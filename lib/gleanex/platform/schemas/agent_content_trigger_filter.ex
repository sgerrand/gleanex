defmodule Gleanex.Platform.AgentContentTriggerFilter do
  @moduledoc """
  Provides struct and type for a AgentContentTriggerFilter
  """

  @type t :: %__MODULE__{field: String.t(), operator: String.t(), values: [String.t()] | nil}

  defstruct [:field, :operator, :values]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      field: :string,
      operator: {:enum, ["IS_ONE_OF", "IS_NOT_ONE_OF", "CONTAINS", "FIELD_CHANGED"]},
      values: [:string]
    ]
  end
end
