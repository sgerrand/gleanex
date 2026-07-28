defmodule Gleanex.Client.ObjectPermissions do
  @moduledoc """
  Provides struct and type for a ObjectPermissions
  """

  @type t :: %__MODULE__{write: Gleanex.Client.WritePermission.t() | nil}

  defstruct [:write]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [write: {Gleanex.Client.WritePermission, :t}]
  end
end
