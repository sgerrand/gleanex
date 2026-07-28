defmodule Gleanex.Indexing.CustomMetadataPutRequest do
  @moduledoc """
  Provides struct and type for a CustomMetadataPutRequest
  """

  @type t :: %__MODULE__{customMetadata: [Gleanex.Indexing.CustomProperty.t()]}

  defstruct [:customMetadata]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [customMetadata: [{Gleanex.Indexing.CustomProperty, :t}]]
  end
end
