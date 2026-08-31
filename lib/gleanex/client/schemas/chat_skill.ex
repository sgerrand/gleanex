defmodule Gleanex.Client.ChatSkill do
  @moduledoc """
  Provides struct and type for a ChatSkill
  """

  @type t :: %__MODULE__{id: String.t(), name: String.t() | nil, url: String.t() | nil}

  defstruct [:id, :name, :url]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [id: :string, name: :string, url: :string]
  end
end
