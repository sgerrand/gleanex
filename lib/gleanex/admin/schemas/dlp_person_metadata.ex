defmodule Gleanex.Admin.DlpPersonMetadata do
  @moduledoc """
  Provides struct and type for a DlpPersonMetadata
  """

  @type t :: %__MODULE__{email: String.t() | nil, firstName: String.t() | nil}

  defstruct [:email, :firstName]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [email: :string, firstName: :string]
  end
end
