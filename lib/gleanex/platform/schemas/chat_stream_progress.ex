defmodule Gleanex.Platform.ChatStreamProgress do
  @moduledoc """
  Provides struct and type for a ChatStreamProgress
  """

  @type t :: %__MODULE__{response_id: String.t(), text: String.t(), type: String.t()}

  defstruct [:response_id, :text, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [response_id: :string, text: :string, type: {:const, "RESPONSE_PROGRESS"}]
  end
end
