defmodule Gleanex.Client.Message do
  @moduledoc """
  Provides struct and type for a Message
  """

  @type t :: %__MODULE__{
          content: [Gleanex.Client.MessageTextBlock.t()] | nil,
          messageTrackingToken: String.t() | nil,
          role: String.t() | nil,
          traceId: String.t() | nil
        }

  defstruct [:content, :messageTrackingToken, :role, :traceId]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      content: [{Gleanex.Client.MessageTextBlock, :t}],
      messageTrackingToken: :string,
      role: :string,
      traceId: :string
    ]
  end
end
