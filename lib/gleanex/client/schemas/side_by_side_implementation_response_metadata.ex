defmodule Gleanex.Client.SideBySideImplementationResponseMetadata do
  @moduledoc """
  Provides struct and type for a SideBySideImplementationResponseMetadata
  """

  @type t :: %__MODULE__{
          latencyMs: integer | nil,
          modelUsed: String.t() | nil,
          tokenCount: integer | nil
        }

  defstruct [:latencyMs, :modelUsed, :tokenCount]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [latencyMs: :integer, modelUsed: :string, tokenCount: :integer]
  end
end
