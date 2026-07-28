defmodule Gleanex.Client.ResultsDescription do
  @moduledoc """
  Provides struct and type for a ResultsDescription
  """

  @type t :: %__MODULE__{iconConfig: Gleanex.Client.IconConfig.t() | nil, text: String.t() | nil}

  defstruct [:iconConfig, :text]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [iconConfig: {Gleanex.Client.IconConfig, :t}, text: :string]
  end
end
