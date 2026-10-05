defmodule Gleanex.Platform.TriggerUpdateRequest do
  @moduledoc """
  Provides struct and type for a TriggerUpdateRequest
  """

  @type t :: %__MODULE__{
          delivery: Gleanex.Platform.TriggerDelivery.t() | nil,
          description: String.t() | nil,
          inputs: map | nil,
          status: String.t() | nil
        }

  defstruct [:delivery, :description, :inputs, :status]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      delivery: {Gleanex.Platform.TriggerDelivery, :t},
      description: :string,
      inputs: :map,
      status: {:enum, ["ENABLED", "DISABLED"]}
    ]
  end
end
