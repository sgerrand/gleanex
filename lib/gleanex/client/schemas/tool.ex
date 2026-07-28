defmodule Gleanex.Client.Tool do
  @moduledoc """
  Provides struct and type for a Tool
  """

  @type t :: %__MODULE__{
          description: String.t() | nil,
          displayName: String.t() | nil,
          name: String.t() | nil,
          parameters: map | nil,
          type: String.t() | nil
        }

  defstruct [:description, :displayName, :name, :parameters, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      description: :string,
      displayName: :string,
      name: :string,
      parameters: :map,
      type: {:enum, ["READ", "WRITE"]}
    ]
  end
end
