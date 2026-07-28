defmodule Gleanex.Client.CustomFieldValueHyperlink do
  @moduledoc """
  Provides struct and type for a CustomFieldValueHyperlink
  """

  @type t :: %__MODULE__{urlAnchor: String.t() | nil, urlLink: String.t() | nil}

  defstruct [:urlAnchor, :urlLink]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [urlAnchor: :string, urlLink: :string]
  end
end
