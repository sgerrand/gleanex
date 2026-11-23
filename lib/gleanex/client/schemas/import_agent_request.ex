defmodule Gleanex.Client.ImportAgentRequest do
  @moduledoc """
  Provides struct and type for a ImportAgentRequest
  """

  @type t :: %__MODULE__{
          bundle: binary,
          commitMessage: String.t() | nil,
          gitAuthorId: String.t() | nil,
          gitCommitSha: String.t() | nil,
          isDraft: boolean | nil,
          publishedBaselineHash: String.t() | nil,
          syncMode: String.t() | nil,
          versionSource: String.t() | nil
        }

  defstruct [
    :bundle,
    :commitMessage,
    :gitAuthorId,
    :gitCommitSha,
    :isDraft,
    :publishedBaselineHash,
    :syncMode,
    :versionSource
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      bundle: {:string, "binary"},
      commitMessage: :string,
      gitAuthorId: :string,
      gitCommitSha: :string,
      isDraft: :boolean,
      publishedBaselineHash: :string,
      syncMode: {:enum, ["STAGED", "PUBLISHED"]},
      versionSource: {:enum, ["GIT", "USER"]}
    ]
  end
end
