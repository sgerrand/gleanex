defmodule Gleanex.Indexing.PermissionsGroupIntersectionDefinition do
  @moduledoc """
  Provides struct and type for a PermissionsGroupIntersectionDefinition
  """

  @type t :: %__MODULE__{requiredGroups: [String.t()] | nil}

  defstruct [:requiredGroups]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [requiredGroups: [:string]]
  end
end
