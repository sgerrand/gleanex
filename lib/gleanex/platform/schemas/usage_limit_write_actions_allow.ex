defmodule Gleanex.Platform.UsageLimitWriteActionsAllow do
  @moduledoc """
  Provides struct and type for a UsageLimitWriteActionsAllow
  """

  @type t :: %__MODULE__{models: [String.t()] | nil}

  defstruct [:models]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [models: [:string]]
  end
end
