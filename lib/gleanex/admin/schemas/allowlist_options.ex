defmodule Gleanex.Admin.AllowlistOptions do
  @moduledoc """
  Provides struct and type for a AllowlistOptions
  """

  @type t :: %__MODULE__{regexes: [String.t()] | nil, terms: [String.t()] | nil}

  defstruct [:regexes, :terms]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [regexes: [:string], terms: [:string]]
  end
end
