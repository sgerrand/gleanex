defmodule Gleanex.Platform.TriggerPresetSummary do
  @moduledoc """
  Provides struct and type for a TriggerPresetSummary
  """

  @type t :: %__MODULE__{
          datasource: String.t(),
          description: String.t() | nil,
          display_name: String.t(),
          preset_id: String.t()
        }

  defstruct [:datasource, :description, :display_name, :preset_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [datasource: :string, description: :string, display_name: :string, preset_id: :string]
  end
end
