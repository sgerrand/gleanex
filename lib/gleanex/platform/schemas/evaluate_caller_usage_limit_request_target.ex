defmodule Gleanex.Platform.EvaluateCallerUsageLimitRequestTarget do
  @moduledoc """
  Provides struct and type for a EvaluateCallerUsageLimitRequestTarget
  """

  @type t :: %__MODULE__{client_id: map}

  defstruct [:client_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [client_id: :map]
  end
end
