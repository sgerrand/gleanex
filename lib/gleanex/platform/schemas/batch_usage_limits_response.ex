defmodule Gleanex.Platform.BatchUsageLimitsResponse do
  @moduledoc """
  Provides struct and type for a BatchUsageLimitsResponse
  """

  @type t :: %__MODULE__{request_id: String.t(), results: [Gleanex.Platform.UsageLimit.t()]}

  defstruct [:request_id, :results]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [request_id: :string, results: [{Gleanex.Platform.UsageLimit, :t}]]
  end
end
