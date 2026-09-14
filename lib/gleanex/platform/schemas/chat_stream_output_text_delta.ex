defmodule Gleanex.Platform.ChatStreamOutputTextDelta do
  @moduledoc """
  Provides struct and type for a ChatStreamOutputTextDelta
  """

  @type t :: %__MODULE__{delta: String.t(), response_id: String.t(), type: String.t()}

  defstruct [:delta, :response_id, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [delta: :string, response_id: :string, type: {:const, "RESPONSE_OUTPUT_TEXT_DELTA"}]
  end
end
