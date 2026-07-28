defmodule Gleanex.Admin.ErrorResponse do
  @moduledoc """
  Provides struct and type for a ErrorResponse
  """

  @type t :: %__MODULE__{message: String.t() | nil}

  defstruct [:message]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [message: :string]
  end
end
