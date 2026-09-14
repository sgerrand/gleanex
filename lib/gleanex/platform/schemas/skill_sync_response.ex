defmodule Gleanex.Platform.SkillSyncResponse do
  @moduledoc """
  Provides struct and type for a SkillSyncResponse
  """

  @type t :: %__MODULE__{
          commit_sha: String.t(),
          request_id: String.t(),
          sync_status: String.t(),
          updated: boolean
        }

  defstruct [:commit_sha, :request_id, :sync_status, :updated]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      commit_sha: :string,
      request_id: :string,
      sync_status: {:const, "UP_TO_DATE"},
      updated: :boolean
    ]
  end
end
