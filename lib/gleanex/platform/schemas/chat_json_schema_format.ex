defmodule Gleanex.Platform.ChatJsonSchemaFormat do
  @moduledoc """
  Provides struct and type for a ChatJsonSchemaFormat
  """

  @type t :: %__MODULE__{
          description: String.t() | nil,
          name: String.t(),
          schema: map,
          strict: boolean | nil,
          type: String.t()
        }

  defstruct [:description, :name, :schema, :strict, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      description: :string,
      name: :string,
      schema: :map,
      strict: :boolean,
      type: {:const, "JSON_SCHEMA"}
    ]
  end
end
