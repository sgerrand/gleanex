defmodule Gleanex.Platform.ChatCompletedResponse do
  @moduledoc """
  Provides struct and type for a ChatCompletedResponse
  """

  @type t :: %__MODULE__{
          conversation_id: String.t() | nil,
          created_at: DateTime.t(),
          id: String.t(),
          object: String.t(),
          output: [Gleanex.Platform.ChatOutputMessage.t()],
          request_id: String.t(),
          status: String.t(),
          store: boolean
        }

  defstruct [:conversation_id, :created_at, :id, :object, :output, :request_id, :status, :store]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      conversation_id: :string,
      created_at: {:string, "date-time"},
      id: :string,
      object: {:const, "response"},
      output: [{Gleanex.Platform.ChatOutputMessage, :t}],
      request_id: :string,
      status: {:const, "completed"},
      store: :boolean
    ]
  end
end
