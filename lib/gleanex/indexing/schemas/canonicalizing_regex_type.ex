defmodule Gleanex.Indexing.CanonicalizingRegexType do
  @moduledoc """
  Provides struct and type for a CanonicalizingRegexType
  """

  @type t :: %__MODULE__{matchRegex: String.t() | nil, rewriteRegex: String.t() | nil}

  defstruct [:matchRegex, :rewriteRegex]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [matchRegex: :string, rewriteRegex: :string]
  end
end
