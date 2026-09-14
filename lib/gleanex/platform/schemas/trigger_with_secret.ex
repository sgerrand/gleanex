defmodule Gleanex.Platform.TriggerWithSecret do
  @moduledoc """
  Provides struct and type for a TriggerWithSecret
  """

  @type t :: %__MODULE__{
          created_at: DateTime.t() | nil,
          delivery: Gleanex.Platform.TriggerDelivery.t() | nil,
          description: String.t() | nil,
          inputs: map | nil,
          preset_id: String.t() | nil,
          signing_secret: String.t() | nil,
          status: String.t() | nil,
          trigger_id: String.t() | nil,
          updated_at: DateTime.t() | nil
        }

  defstruct [
    :created_at,
    :delivery,
    :description,
    :inputs,
    :preset_id,
    :signing_secret,
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
      signing_secret: :string,
      status: {:enum, ["ENABLED", "DISABLED"]},
      trigger_id: :string,
      updated_at: {:string, "date-time"}
    ]
  end
end
