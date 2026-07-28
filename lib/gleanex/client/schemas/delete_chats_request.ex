defmodule Gleanex.Client.DeleteChatsRequest do
  @moduledoc """
  Provides struct and type for a DeleteChatsRequest
  """

  @type t :: %__MODULE__{ids: [String.t()]}

  defstruct [:ids]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [ids: [:string]]
  end
end
