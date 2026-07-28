defmodule Gleanex.Client.CustomerMetadata do
  @moduledoc """
  Provides struct and type for a CustomerMetadata
  """

  @type t :: %__MODULE__{customData: map | nil, datasourceId: String.t() | nil}

  defstruct [:customData, :datasourceId]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [customData: :map, datasourceId: :string]
  end
end
