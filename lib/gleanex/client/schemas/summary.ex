defmodule Gleanex.Client.Summary do
  @moduledoc """
  Provides struct and type for a Summary
  """

  @type t :: %__MODULE__{followUpPrompts: [String.t()] | nil, text: String.t() | nil}

  defstruct [:followUpPrompts, :text]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [followUpPrompts: [:string], text: :string]
  end
end
