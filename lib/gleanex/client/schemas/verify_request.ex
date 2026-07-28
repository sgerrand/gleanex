defmodule Gleanex.Client.VerifyRequest do
  @moduledoc """
  Provides struct and type for a VerifyRequest
  """

  @type t :: %__MODULE__{action: String.t() | nil, documentId: String.t()}

  defstruct [:action, :documentId]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [action: {:enum, ["VERIFY", "DEPRECATE", "UNVERIFY"]}, documentId: :string]
  end
end
