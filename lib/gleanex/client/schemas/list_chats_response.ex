defmodule Gleanex.Client.ListChatsResponse do
  @moduledoc """
  Provides struct and type for a ListChatsResponse
  """

  @type t :: %__MODULE__{
          chatResults: [Gleanex.Client.ChatMetadataResult.t()] | nil,
          cursor: String.t() | nil
        }

  defstruct [:chatResults, :cursor]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [chatResults: [{Gleanex.Client.ChatMetadataResult, :t}], cursor: :string]
  end
end
