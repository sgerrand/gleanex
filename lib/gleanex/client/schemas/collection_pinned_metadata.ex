defmodule Gleanex.Client.CollectionPinnedMetadata do
  @moduledoc """
  Provides struct and type for a CollectionPinnedMetadata
  """

  @type t :: %__MODULE__{
          eligiblePins: [Gleanex.Client.CollectionPinMetadata.t()] | nil,
          existingPins: [Gleanex.Client.CollectionPinTarget.t()] | nil
        }

  defstruct [:eligiblePins, :existingPins]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      eligiblePins: [{Gleanex.Client.CollectionPinMetadata, :t}],
      existingPins: [{Gleanex.Client.CollectionPinTarget, :t}]
    ]
  end
end
