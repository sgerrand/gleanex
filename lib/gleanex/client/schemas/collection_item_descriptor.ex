defmodule Gleanex.Client.CollectionItemDescriptor do
  @moduledoc """
  Provides struct and type for a CollectionItemDescriptor
  """

  @type t :: %__MODULE__{
          description: String.t() | nil,
          icon: String.t() | nil,
          name: String.t() | nil
        }

  defstruct [:description, :icon, :name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [description: :string, icon: :string, name: :string]
  end
end
