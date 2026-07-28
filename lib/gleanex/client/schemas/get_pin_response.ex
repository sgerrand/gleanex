defmodule Gleanex.Client.GetPinResponse do
  @moduledoc """
  Provides struct and type for a GetPinResponse
  """

  @type t :: %__MODULE__{pin: Gleanex.Client.PinDocument.t() | nil}

  defstruct [:pin]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [pin: {Gleanex.Client.PinDocument, :t}]
  end
end
