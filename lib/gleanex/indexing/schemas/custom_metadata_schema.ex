defmodule Gleanex.Indexing.CustomMetadataSchema do
  @moduledoc """
  Provides struct and type for a CustomMetadataSchema
  """

  @type t :: %__MODULE__{metadataKeys: [Gleanex.Indexing.PropertyDefinition.t()]}

  defstruct [:metadataKeys]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [metadataKeys: [{Gleanex.Indexing.PropertyDefinition, :t}]]
  end
end
