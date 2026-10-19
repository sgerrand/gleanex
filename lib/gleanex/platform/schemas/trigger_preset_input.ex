defmodule Gleanex.Platform.TriggerPresetInput do
  @moduledoc """
  Provides struct and type for a TriggerPresetInput
  """

  @type t :: %__MODULE__{
          display_name: String.t(),
          field: String.t(),
          is_required: boolean,
          is_truncated: boolean | nil,
          type: String.t(),
          values: [Gleanex.Platform.TriggerPresetInputValue.t()] | nil
        }

  defstruct [:display_name, :field, :is_required, :is_truncated, :type, :values]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      display_name: :string,
      field: :string,
      is_required: :boolean,
      is_truncated: :boolean,
      type: {:enum, ["PICKLIST", "TEXT", "USER"]},
      values: [{Gleanex.Platform.TriggerPresetInputValue, :t}]
    ]
  end
end
