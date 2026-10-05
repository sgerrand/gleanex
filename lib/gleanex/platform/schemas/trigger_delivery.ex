defmodule Gleanex.Platform.TriggerDelivery do
  @moduledoc """
  Provides struct and type for a TriggerDelivery
  """

  @type t :: %__MODULE__{auth: Gleanex.Platform.TriggerAuth.t() | nil, webhook_url: String.t()}

  defstruct [:auth, :webhook_url]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [auth: {Gleanex.Platform.TriggerAuth, :t}, webhook_url: {:string, "uri"}]
  end
end
