defmodule Gleanex.Indexing.IndexTeamRequest do
  @moduledoc """
  Provides struct and type for a IndexTeamRequest
  """

  @type t :: %__MODULE__{team: Gleanex.Indexing.TeamInfoDefinition.t(), version: integer | nil}

  defstruct [:team, :version]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [team: {Gleanex.Indexing.TeamInfoDefinition, :t}, version: {:integer, "int64"}]
  end
end
