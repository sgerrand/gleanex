defmodule Gleanex.Platform.SkillSyncResponse do
  @moduledoc """
  Provides struct and type for a SkillSyncResponse
  """

  @type t :: %__MODULE__{commit_sha: String.t(), is_updated: boolean, request_id: String.t()}

  defstruct [:commit_sha, :is_updated, :request_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [commit_sha: :string, is_updated: :boolean, request_id: :string]
  end
end
