defmodule Gleanex.Platform.UsageLimitWriteActions do
  @moduledoc """
  Provides struct and type for a UsageLimitWriteActions
  """

  @type t :: %__MODULE__{allow: Gleanex.Platform.UsageLimitWriteActionsAllow.t() | nil}

  defstruct [:allow]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [allow: {Gleanex.Platform.UsageLimitWriteActionsAllow, :t}]
  end
end
