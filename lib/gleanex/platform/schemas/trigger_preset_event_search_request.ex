defmodule Gleanex.Platform.TriggerPresetEventSearchRequest do
  @moduledoc """
  Provides struct and type for a TriggerPresetEventSearchRequest
  """

  @type t :: %__MODULE__{inputs: map | nil, page_size: integer | nil}

  defstruct [:inputs, :page_size]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [inputs: :map, page_size: :integer]
  end
end
