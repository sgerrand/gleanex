defmodule Gleanex.Platform.ChatResponseError do
  @moduledoc """
  Provides struct and type for a ChatResponseError
  """

  @type t :: %__MODULE__{code: String.t() | nil, message: String.t()}

  defstruct [:code, :message]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [code: {:union, [:string, :null]}, message: :string]
  end
end
