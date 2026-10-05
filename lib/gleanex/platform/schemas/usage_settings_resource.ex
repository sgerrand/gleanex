defmodule Gleanex.Platform.UsageSettingsResource do
  @moduledoc """
  Provides struct and type for a UsageSettingsResource
  """

  @type t :: %__MODULE__{
          limit_increase_requests: Gleanex.Platform.LimitIncreaseRequestSettings.t() | nil,
          multiple_membership_resolution:
            Gleanex.Platform.MultipleMembershipResolutionSettings.t() | nil,
          updated_at: DateTime.t() | nil
        }

  defstruct [:limit_increase_requests, :multiple_membership_resolution, :updated_at]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      limit_increase_requests: {Gleanex.Platform.LimitIncreaseRequestSettings, :t},
      multiple_membership_resolution: {Gleanex.Platform.MultipleMembershipResolutionSettings, :t},
      updated_at: {:string, "date-time"}
    ]
  end
end
