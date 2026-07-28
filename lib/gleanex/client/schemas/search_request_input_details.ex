defmodule Gleanex.Client.SearchRequestInputDetails do
  @moduledoc """
  Provides struct and type for a SearchRequestInputDetails
  """

  @type t :: %__MODULE__{hasCopyPaste: boolean | nil}

  defstruct [:hasCopyPaste]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [hasCopyPaste: :boolean]
  end
end
