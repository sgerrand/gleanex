defmodule Gleanex.Client.AgentRunWaitResponse do
  @moduledoc """
  Provides struct and type for a AgentRunWaitResponse
  """

  @type t :: %__MODULE__{
          messages: [Gleanex.Client.Message.t()] | nil,
          run: Gleanex.Client.AgentRun.t() | nil
        }

  defstruct [:messages, :run]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [messages: [{Gleanex.Client.Message, :t}], run: {Gleanex.Client.AgentRun, :t}]
  end
end
