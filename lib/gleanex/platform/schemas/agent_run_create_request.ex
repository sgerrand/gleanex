defmodule Gleanex.Platform.AgentRunCreateRequest do
  @moduledoc """
  Provides struct and type for a AgentRunCreateRequest
  """

  @type t :: %__MODULE__{
          input: map | nil,
          messages: [Gleanex.Platform.Message.t()] | nil,
          metadata: map | nil,
          stream: boolean | nil
        }

  defstruct [:input, :messages, :metadata, :stream]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [input: :map, messages: [{Gleanex.Platform.Message, :t}], metadata: :map, stream: :boolean]
  end
end
