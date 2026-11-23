defmodule Gleanex.Platform.AgentLlmModel do
  @moduledoc """
  Provides struct and type for a AgentLlmModel
  """

  @type t :: %__MODULE__{
          auto_upgrade: boolean | nil,
          mode: String.t() | nil,
          model_set_id: String.t() | nil
        }

  defstruct [:auto_upgrade, :mode, :model_set_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [auto_upgrade: :boolean, mode: {:enum, ["ADVANCED", "FAST"]}, model_set_id: :string]
  end
end
