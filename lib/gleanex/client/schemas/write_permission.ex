defmodule Gleanex.Client.WritePermission do
  @moduledoc """
  Provides struct and type for a WritePermission
  """

  @type t :: %__MODULE__{
          create: boolean | nil,
          delete: boolean | nil,
          scopeType: String.t() | nil,
          update: boolean | nil
        }

  defstruct [:create, :delete, :scopeType, :update]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [create: :boolean, delete: :boolean, scopeType: {:enum, ["GLOBAL", "OWN"]}, update: :boolean]
  end
end
