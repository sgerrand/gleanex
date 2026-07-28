defmodule Gleanex.Client.VerificationFeed do
  @moduledoc """
  Provides struct and type for a VerificationFeed
  """

  @type t :: %__MODULE__{documents: [Gleanex.Client.Verification.t()] | nil}

  defstruct [:documents]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [documents: [{Gleanex.Client.Verification, :t}]]
  end
end
