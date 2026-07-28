defmodule Gleanex.Client.ListPinsResponse do
  @moduledoc """
  Provides struct and type for a ListPinsResponse
  """

  @type t :: %__MODULE__{pins: [Gleanex.Client.PinDocument.t()]}

  defstruct [:pins]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [pins: [{Gleanex.Client.PinDocument, :t}]]
  end
end
