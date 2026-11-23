defmodule Gleanex.Platform.UpsertUsageLimitResponse do
  @moduledoc """
  Provides struct and type for a UpsertUsageLimitResponse
  """

  @type t :: %__MODULE__{request_id: String.t(), usage_limit: Gleanex.Platform.UsageLimit.t()}

  defstruct [:request_id, :usage_limit]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [request_id: :string, usage_limit: {Gleanex.Platform.UsageLimit, :t}]
  end
end
