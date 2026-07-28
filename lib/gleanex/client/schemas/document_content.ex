defmodule Gleanex.Client.DocumentContent do
  @moduledoc """
  Provides struct and type for a DocumentContent
  """

  @type t :: %__MODULE__{fullTextList: [String.t()] | nil}

  defstruct [:fullTextList]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [fullTextList: [:string]]
  end
end
