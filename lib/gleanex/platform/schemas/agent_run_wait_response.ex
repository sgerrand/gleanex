defmodule Gleanex.Platform.AgentRunWaitResponse do
  @moduledoc """
  Provides struct and type for a AgentRunWaitResponse
  """

  @type t :: %__MODULE__{
          messages: [Gleanex.Platform.Message.t()] | nil,
          request_id: String.t(),
          run: Gleanex.Platform.AgentRun.t() | nil
        }

  defstruct [:messages, :request_id, :run]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      messages: [{Gleanex.Platform.Message, :t}],
      request_id: :string,
      run: {Gleanex.Platform.AgentRun, :t}
    ]
  end
end
