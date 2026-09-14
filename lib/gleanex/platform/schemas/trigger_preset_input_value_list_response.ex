defmodule Gleanex.Platform.TriggerPresetInputValueListResponse do
  @moduledoc """
  Provides struct and type for a TriggerPresetInputValueListResponse
  """

  @type t :: %__MODULE__{
          is_truncated: boolean,
          request_id: String.t(),
          results: [Gleanex.Platform.TriggerPresetInputValue.t()]
        }

  defstruct [:is_truncated, :request_id, :results]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      is_truncated: :boolean,
      request_id: :string,
      results: [{Gleanex.Platform.TriggerPresetInputValue, :t}]
    ]
  end
end
