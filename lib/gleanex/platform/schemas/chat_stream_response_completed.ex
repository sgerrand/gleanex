defmodule Gleanex.Platform.ChatStreamResponseCompleted do
  @moduledoc """
  Provides struct and type for a ChatStreamResponseCompleted
  """

  @type t :: %__MODULE__{
          response: Gleanex.Platform.ChatCompletedResponse.t(),
          response_id: String.t(),
          type: String.t()
        }

  defstruct [:response, :response_id, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      response: {Gleanex.Platform.ChatCompletedResponse, :t},
      response_id: :string,
      type: {:const, "RESPONSE_COMPLETED"}
    ]
  end
end
