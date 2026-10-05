defmodule Gleanex.Platform.UsageSelector do
  @moduledoc """
  Provides struct and type for a UsageSelector
  """

  @type t :: %__MODULE__{client_id: String.t() | nil, period: Gleanex.Platform.Period.t()}

  defstruct [:client_id, :period]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [client_id: :string, period: {Gleanex.Platform.Period, :t}]
  end
end
