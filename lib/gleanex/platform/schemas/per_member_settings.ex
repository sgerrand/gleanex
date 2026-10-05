defmodule Gleanex.Platform.PerMemberSettings do
  @moduledoc """
  Provides struct and type for a PerMemberSettings
  """

  @type t :: %__MODULE__{idp_groups: String.t()}

  defstruct [:idp_groups]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [idp_groups: {:enum, ["HIGHEST", "LOWEST"]}]
  end
end
