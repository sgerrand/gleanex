defmodule Gleanex.Client.SearchAgentsResponse do
  @moduledoc """
  Provides struct and type for a SearchAgentsResponse
  """

  @type t :: %__MODULE__{agents: [Gleanex.Client.Agent.t()] | nil}

  defstruct [:agents]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [agents: [{Gleanex.Client.Agent, :t}]]
  end
end
