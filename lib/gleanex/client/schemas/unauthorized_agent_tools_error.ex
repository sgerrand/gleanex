defmodule Gleanex.Client.UnauthorizedAgentToolsError do
  @moduledoc """
  Provides struct and type for a UnauthorizedAgentToolsError
  """

  @type t :: %__MODULE__{
          authenticationSuggestions: [Gleanex.Client.ServerToolRequest.t()],
          message: String.t()
        }

  defstruct [:authenticationSuggestions, :message]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [authenticationSuggestions: [{Gleanex.Client.ServerToolRequest, :t}], message: :string]
  end
end
