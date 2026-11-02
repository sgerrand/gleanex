defmodule Gleanex.Platform.UsageSettingsResponse do
  @moduledoc """
  Provides struct and type for a UsageSettingsResponse
  """

  @type t :: %__MODULE__{
          request_id: String.t(),
          usage_settings: Gleanex.Platform.UsageSettingsResource.t()
        }

  defstruct [:request_id, :usage_settings]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [request_id: :string, usage_settings: {Gleanex.Platform.UsageSettingsResource, :t}]
  end
end
