defmodule Gleanex.Client.GetChatRequest do
  @moduledoc """
  Provides struct and type for a GetChatRequest
  """

  @type t :: %__MODULE__{
          after: String.t() | nil,
          before: String.t() | nil,
          first: integer | nil,
          id: String.t(),
          last: integer | nil
        }

  defstruct [:after, :before, :first, :id, :last]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      after: :string,
      before: :string,
      first: {:integer, "int32"},
      id: :string,
      last: {:integer, "int32"}
    ]
  end
end
