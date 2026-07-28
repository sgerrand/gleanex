defmodule Gleanex.Client.CustomEntityMetadata do
  @moduledoc """
  Provides struct and type for a CustomEntityMetadata
  """

  @type t :: %__MODULE__{customData: map | nil}

  defstruct [:customData]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [customData: :map]
  end
end
