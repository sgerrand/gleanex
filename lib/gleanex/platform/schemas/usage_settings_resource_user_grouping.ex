defmodule Gleanex.Platform.UsageSettingsResourceUserGrouping do
  @moduledoc """
  Provides struct and types for a UsageSettingsResourceUserGrouping
  """

  @type t :: %__MODULE__{mode: String.t() | nil}

  defstruct [:mode]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [mode: {:enum, ["DEPARTMENT", "IDP_GROUP"]}]
  end
end
