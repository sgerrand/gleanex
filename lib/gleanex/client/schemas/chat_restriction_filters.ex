defmodule Gleanex.Client.ChatRestrictionFilters do
  @moduledoc """
  Provides struct and type for a ChatRestrictionFilters
  """

  @type t :: %__MODULE__{
          containerSpecs: [map] | nil,
          datasourceInstances: [String.t()] | nil,
          documentSpecs: [map] | nil
        }

  defstruct [:containerSpecs, :datasourceInstances, :documentSpecs]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [containerSpecs: [:map], datasourceInstances: [:string], documentSpecs: [:map]]
  end
end
