defmodule Gleanex.Platform.GetOAuthClientResponse do
  @moduledoc """
  Provides struct and type for a GetOAuthClientResponse
  """

  @type t :: %__MODULE__{client: Gleanex.Platform.OAuthClient.t(), request_id: String.t()}

  defstruct [:client, :request_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [client: {Gleanex.Platform.OAuthClient, :t}, request_id: :string]
  end
end
