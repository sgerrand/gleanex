defmodule Gleanex.Admin.DlpPerson do
  @moduledoc """
  Provides struct and type for a DlpPerson
  """

  @type t :: %__MODULE__{
          metadata: Gleanex.Admin.DlpPersonMetadata.t() | nil,
          name: String.t(),
          obfuscatedId: String.t()
        }

  defstruct [:metadata, :name, :obfuscatedId]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [metadata: {Gleanex.Admin.DlpPersonMetadata, :t}, name: :string, obfuscatedId: :string]
  end
end
