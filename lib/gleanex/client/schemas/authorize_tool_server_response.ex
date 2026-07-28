defmodule Gleanex.Client.AuthorizeToolServerResponse do
  @moduledoc """
  Provides struct and type for a AuthorizeToolServerResponse
  """

  @type t :: %__MODULE__{authorizationUrl: String.t()}

  defstruct [:authorizationUrl]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [authorizationUrl: :string]
  end
end
