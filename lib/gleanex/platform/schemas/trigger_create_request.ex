defmodule Gleanex.Platform.TriggerCreateRequest do
  @moduledoc """
  Provides struct and type for a TriggerCreateRequest
  """

  @type t :: %__MODULE__{
          delivery: Gleanex.Platform.TriggerDelivery.t(),
          description: String.t() | nil,
          inputs: map | nil,
          preset_id: String.t()
        }

  defstruct [:delivery, :description, :inputs, :preset_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      delivery: {Gleanex.Platform.TriggerDelivery, :t},
      description: :string,
      inputs: :map,
      preset_id: :string
    ]
  end
end
