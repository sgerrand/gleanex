defmodule Gleanex.Client.CustomFieldValueStr do
  @moduledoc """
  Provides struct and type for a CustomFieldValueStr
  """

  @type t :: %__MODULE__{strText: String.t() | nil}

  defstruct [:strText]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [strText: :string]
  end
end
