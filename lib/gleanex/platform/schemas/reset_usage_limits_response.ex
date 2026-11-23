defmodule Gleanex.Platform.ResetUsageLimitsResponse do
  @moduledoc """
  Provides struct and type for a ResetUsageLimitsResponse
  """

  @type t :: %__MODULE__{is_configuration_removed: boolean, request_id: String.t()}

  defstruct [:is_configuration_removed, :request_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [is_configuration_removed: :boolean, request_id: :string]
  end
end
