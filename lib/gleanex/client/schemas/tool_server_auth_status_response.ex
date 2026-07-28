defmodule Gleanex.Client.ToolServerAuthStatusResponse do
  @moduledoc """
  Provides struct and type for a ToolServerAuthStatusResponse
  """

  @type t :: %__MODULE__{
          authStatus: String.t(),
          authType: String.t(),
          description: String.t() | nil,
          displayName: String.t() | nil,
          logoUrl: String.t() | nil
        }

  defstruct [:authStatus, :authType, :description, :displayName, :logoUrl]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      authStatus: {:enum, ["AWAITING_AUTH", "AUTHORIZED"]},
      authType: {:enum, ["AUTH_USER_OAUTH", "AUTH_ADMIN", "AUTH_NONE"]},
      description: :string,
      displayName: :string,
      logoUrl: :string
    ]
  end
end
