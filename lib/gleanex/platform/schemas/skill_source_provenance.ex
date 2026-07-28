defmodule Gleanex.Platform.SkillSourceProvenance do
  @moduledoc """
  Provides struct and type for a SkillSourceProvenance
  """

  @type t :: %__MODULE__{
          commit_sha: String.t() | nil,
          imported_at: DateTime.t() | nil,
          last_synced_at: DateTime.t() | nil,
          source_url: String.t() | nil,
          sync_error: String.t() | nil,
          sync_status: String.t() | nil
        }

  defstruct [:commit_sha, :imported_at, :last_synced_at, :source_url, :sync_error, :sync_status]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      commit_sha: :string,
      imported_at: {:string, "date-time"},
      last_synced_at: {:string, "date-time"},
      source_url: :string,
      sync_error: :string,
      sync_status: {:enum, ["UP_TO_DATE", "UPDATE_AVAILABLE", "SYNC_FAILED"]}
    ]
  end
end
