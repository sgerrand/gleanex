defmodule Gleanex.Platform.AgentToolsetCustomisationData do
  @moduledoc """
  Provides struct and type for a AgentToolsetCustomisationData
  """

  @type t :: %__MODULE__{skip_confirmation: boolean | nil}

  defstruct [:skip_confirmation]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [skip_confirmation: :boolean]
  end
end
