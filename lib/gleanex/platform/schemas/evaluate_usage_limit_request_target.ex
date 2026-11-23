defmodule Gleanex.Platform.EvaluateUsageLimitRequestTarget do
  @moduledoc """
  Provides struct and type for a EvaluateUsageLimitRequestTarget
  """

  @type t :: %__MODULE__{client_id: map, type: String.t() | nil}

  defstruct [:client_id, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [client_id: :map, type: {:enum, ["ORGANIZATION", "USER", "AGENT"]}]
  end
end
