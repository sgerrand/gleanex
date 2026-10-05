defmodule Gleanex.Platform.MultipleMembershipResolutionSettings do
  @moduledoc """
  Provides struct and type for a MultipleMembershipResolutionSettings
  """

  @type t :: %__MODULE__{per_member: Gleanex.Platform.PerMemberSettings.t()}

  defstruct [:per_member]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [per_member: {Gleanex.Platform.PerMemberSettings, :t}]
  end
end
