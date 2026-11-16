defmodule Gleanex.Platform.Trigger do
  @moduledoc """
  Provides struct and type for a Trigger
  """

  @type t :: %__MODULE__{
          created_at: DateTime.t(),
          delivery: Gleanex.Platform.TriggerDelivery.t(),
          description: String.t() | nil,
          inputs: map | nil,
          preset_id: String.t(),
          status: String.t(),
          trigger_id: String.t(),
          updated_at: DateTime.t()
        }

  defstruct [
    :created_at,
    :delivery,
    :description,
    :inputs,
    :preset_id,
    :status,
    :trigger_id,
    :updated_at
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      created_at: {:string, "date-time"},
      delivery: {Gleanex.Platform.TriggerDelivery, :t},
      description: :string,
      inputs: :map,
      preset_id: :string,
      status: {:enum, ["ENABLED", "DISABLED"]},
      trigger_id: :string,
      updated_at: {:string, "date-time"}
    ]
  end
end
