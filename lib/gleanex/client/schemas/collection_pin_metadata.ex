defmodule Gleanex.Client.CollectionPinMetadata do
  @moduledoc """
  Provides struct and type for a CollectionPinMetadata
  """

  @type t :: %__MODULE__{id: integer, target: Gleanex.Client.CollectionPinTarget.t()}

  defstruct [:id, :target]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [id: :integer, target: {Gleanex.Client.CollectionPinTarget, :t}]
  end
end
