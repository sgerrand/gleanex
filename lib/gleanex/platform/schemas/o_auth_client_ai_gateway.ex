defmodule Gleanex.Platform.OAuthClientAiGateway do
  @moduledoc """
  Provides struct and type for a OAuthClientAiGateway
  """

  @type t :: %__MODULE__{usage_client_id: String.t()}

  defstruct [:usage_client_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [usage_client_id: :string]
  end
end
