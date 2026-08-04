defmodule Gleanex.Platform.ChatCreateRequest do
  @moduledoc """
  Provides struct and type for a ChatCreateRequest
  """

  @type t :: %__MODULE__{
          conversation_id: String.t() | nil,
          input: String.t() | [map],
          store: boolean | nil,
          stream: boolean | nil
        }

  defstruct [:conversation_id, :input, :store, :stream]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      conversation_id: :string,
      input: {:union, [:string, [:map]]},
      store: :boolean,
      stream: :boolean
    ]
  end
end
