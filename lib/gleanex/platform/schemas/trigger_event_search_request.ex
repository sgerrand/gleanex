defmodule Gleanex.Platform.TriggerEventSearchRequest do
  @moduledoc """
  Provides struct and type for a TriggerEventSearchRequest
  """

  @type t :: %__MODULE__{page_size: integer | nil}

  defstruct [:page_size]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [page_size: :integer]
  end
end
