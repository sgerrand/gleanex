defmodule Gleanex.Platform.ChatFailedResponse do
  @moduledoc """
  Provides struct and type for a ChatFailedResponse
  """

  @type t :: %__MODULE__{
          conversation_id: String.t() | nil,
          created_at: DateTime.t(),
          error: Gleanex.Platform.ChatResponseError.t(),
          id: String.t(),
          object: String.t(),
          output: [Gleanex.Platform.ChatOutputMessage.t()],
          request_id: String.t(),
          status: String.t(),
          store: boolean
        }

  defstruct [
    :conversation_id,
    :created_at,
    :error,
    :id,
    :object,
    :output,
    :request_id,
    :status,
    :store
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      conversation_id: {:union, [:string, :null]},
      created_at: {:string, "date-time"},
      error: {Gleanex.Platform.ChatResponseError, :t},
      id: :string,
      object: {:const, "RESPONSE"},
      output: [{Gleanex.Platform.ChatOutputMessage, :t}],
      request_id: :string,
      status: {:const, "FAILED"},
      store: :boolean
    ]
  end
end
