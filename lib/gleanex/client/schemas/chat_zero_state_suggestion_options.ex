defmodule Gleanex.Client.ChatZeroStateSuggestionOptions do
  @moduledoc """
  Provides struct and type for a ChatZeroStateSuggestionOptions
  """

  @type t :: %__MODULE__{applicationId: String.t() | nil}

  defstruct [:applicationId]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [applicationId: :string]
  end
end
