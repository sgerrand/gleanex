defmodule Gleanex.Platform.ChatStreamResponseCreated do
  @moduledoc """
  Provides struct and type for a ChatStreamResponseCreated
  """

  @type t :: %__MODULE__{response_id: String.t(), type: String.t()}

  defstruct [:response_id, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [response_id: :string, type: {:const, "RESPONSE_CREATED"}]
  end
end
