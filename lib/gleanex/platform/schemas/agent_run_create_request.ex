defmodule Gleanex.Platform.AgentRunCreateRequest do
  @moduledoc """
  Provides struct and type for a AgentRunCreateRequest
  """

  @type t :: %__MODULE__{
          execution_mode: String.t() | nil,
          input: map | nil,
          messages: [Gleanex.Platform.Message.t()] | nil,
          metadata: map | nil,
          stream: boolean | nil
        }

  defstruct [:execution_mode, :input, :messages, :metadata, :stream]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      execution_mode: {:enum, ["REQUEST_BOUND", "DURABLE"]},
      input: :map,
      messages: [{Gleanex.Platform.Message, :t}],
      metadata: :map,
      stream: :boolean
    ]
  end
end
