defmodule Gleanex.Platform.TriggerPresetGetResponse do
  @moduledoc """
  Provides struct and type for a TriggerPresetGetResponse
  """

  @type t :: %__MODULE__{
          request_id: String.t(),
          trigger_preset: Gleanex.Platform.TriggerPreset.t()
        }

  defstruct [:request_id, :trigger_preset]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [request_id: :string, trigger_preset: {Gleanex.Platform.TriggerPreset, :t}]
  end
end
