defmodule Gleanex.Client.MessagesRequest do
  @moduledoc """
  Provides struct and type for a MessagesRequest
  """

  @type t :: %__MODULE__{
          datasource: String.t(),
          datasourceInstanceDisplayName: String.t() | nil,
          direction: String.t() | nil,
          id: String.t(),
          idType: String.t(),
          includeRootMessage: boolean | nil,
          timestampMillis: integer | nil,
          workspaceId: String.t() | nil
        }

  defstruct [
    :datasource,
    :datasourceInstanceDisplayName,
    :direction,
    :id,
    :idType,
    :includeRootMessage,
    :timestampMillis,
    :workspaceId
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      datasource:
        {:enum, ["SLACK", "SLACKENTGRID", "MICROSOFTTEAMS", "GCHAT", "FACEBOOKWORKPLACE"]},
      datasourceInstanceDisplayName: :string,
      direction: {:enum, ["OLDER", "NEWER"]},
      id: :string,
      idType: {:enum, ["CHANNEL_NAME", "THREAD_ID", "CONVERSATION_ID"]},
      includeRootMessage: :boolean,
      timestampMillis: {:integer, "int64"},
      workspaceId: :string
    ]
  end
end
