defmodule Gleanex.Indexing.Authentication do
  @moduledoc """
  Provides API endpoint related to authentication
  """

  @default_client Gleanex.HTTP

  @doc """
  Rotate token

  Rotates the secret value inside the Indexing API token and returns the new raw secret. All other properties of the token are unchanged. In order to rotate the secret value, include the token as the bearer token in the `/rotatetoken` request. Please refer to [Token rotation](https://developers.glean.com/indexing/authentication/token-rotation) documentation for more information.
  """
  @spec rotatetoken(opts :: keyword) ::
          {:ok, Gleanex.Indexing.RotateTokenResponse.t()} | {:error, Gleanex.Error.t()}
  def rotatetoken(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Gleanex.Indexing.Authentication, :rotatetoken},
      url: "/rotatetoken",
      method: :post,
      response: [{200, {Gleanex.Indexing.RotateTokenResponse, :t}}, {400, :null}, {401, :null}],
      opts: opts
    })
  end
end
