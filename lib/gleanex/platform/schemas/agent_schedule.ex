defmodule Gleanex.Platform.AgentSchedule do
  @moduledoc """
  Provides struct and type for a AgentSchedule
  """

  @type t :: %__MODULE__{
          frequency: String.t(),
          start_at: DateTime.t() | nil,
          timezone: String.t()
        }

  defstruct [:frequency, :start_at, :timezone]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [frequency: :string, start_at: {:string, "date-time"}, timezone: :string]
  end
end
