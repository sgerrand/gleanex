defmodule Gleanex.Client.ActionPreview do
  @moduledoc """
  Provides struct and type for a ActionPreview
  """

  @type t :: %__MODULE__{description: String.t() | nil, markdown: String.t() | nil}

  defstruct [:description, :markdown]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [description: :string, markdown: :string]
  end
end
