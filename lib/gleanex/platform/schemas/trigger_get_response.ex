defmodule Gleanex.Platform.TriggerGetResponse do
  @moduledoc """
  Provides struct and type for a TriggerGetResponse
  """

  @type t :: %__MODULE__{request_id: String.t(), trigger: Gleanex.Platform.Trigger.t()}

  defstruct [:request_id, :trigger]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [request_id: :string, trigger: {Gleanex.Platform.Trigger, :t}]
  end
end
