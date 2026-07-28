defmodule Gleanex.Platform.AgentsSearchResponse do
  @moduledoc """
  Provides struct and type for a AgentsSearchResponse
  """

  @type t :: %__MODULE__{agents: [Gleanex.Platform.Agent.t()], request_id: String.t()}

  defstruct [:agents, :request_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [agents: [{Gleanex.Platform.Agent, :t}], request_id: :string]
  end
end
