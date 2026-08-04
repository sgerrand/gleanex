defmodule Gleanex.Platform.AuthenticationSuggestion do
  @moduledoc """
  Provides struct and type for a AuthenticationSuggestion
  """

  @type t :: %__MODULE__{server_id: String.t(), tool_name: String.t() | nil}

  defstruct [:server_id, :tool_name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [server_id: :string, tool_name: :string]
  end
end
