defmodule Gleanex.Platform.TriggerPreset do
  @moduledoc """
  Provides struct and type for a TriggerPreset
  """

  @type t :: %__MODULE__{
          datasource: String.t() | nil,
          description: String.t() | nil,
          display_name: String.t() | nil,
          inputs: [Gleanex.Platform.TriggerPresetInput.t()] | nil,
          preset_id: String.t() | nil
        }

  defstruct [:datasource, :description, :display_name, :inputs, :preset_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      datasource: :string,
      description: :string,
      display_name: :string,
      inputs: [{Gleanex.Platform.TriggerPresetInput, :t}],
      preset_id: :string
    ]
  end
end
