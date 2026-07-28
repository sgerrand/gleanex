defmodule Gleanex.Client.ToolMetadata do
  @moduledoc """
  Provides struct and type for a ToolMetadata
  """

  @type t :: %__MODULE__{
          actionTypeSource: String.t() | nil,
          auth: Gleanex.Client.AuthConfig.t() | nil,
          authType: String.t() | nil,
          createdAt: DateTime.t() | nil,
          createdBy: Gleanex.Client.PersonObject.t() | nil,
          displayDescription: String.t(),
          displayName: String.t(),
          isSetupFinished: boolean | nil,
          knowledgeType: String.t() | nil,
          lastUpdatedAt: DateTime.t() | nil,
          lastUpdatedBy: Gleanex.Client.PersonObject.t() | nil,
          logoUrl: String.t() | nil,
          name: String.t(),
          objectName: String.t() | nil,
          permissions: Gleanex.Client.ObjectPermissions.t() | nil,
          toolId: String.t() | nil,
          type: String.t(),
          usageInstructions: String.t() | nil,
          writeActionType: String.t() | nil
        }

  defstruct [
    :actionTypeSource,
    :auth,
    :authType,
    :createdAt,
    :createdBy,
    :displayDescription,
    :displayName,
    :isSetupFinished,
    :knowledgeType,
    :lastUpdatedAt,
    :lastUpdatedBy,
    :logoUrl,
    :name,
    :objectName,
    :permissions,
    :toolId,
    :type,
    :usageInstructions,
    :writeActionType
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      actionTypeSource:
        {:enum, ["MCP_ANNOTATION", "ADMIN_OVERRIDE", "NONE", "NATIVE_TOOL_DEFINITION"]},
      auth: {Gleanex.Client.AuthConfig, :t},
      authType: {:enum, ["NONE", "OAUTH_USER", "OAUTH_ADMIN", "API_KEY", "BASIC_AUTH", "DWD"]},
      createdAt: {:string, "date-time"},
      createdBy: {Gleanex.Client.PersonObject, :t},
      displayDescription: :string,
      displayName: :string,
      isSetupFinished: :boolean,
      knowledgeType: {:enum, ["NEUTRAL_KNOWLEDGE", "COMPANY_KNOWLEDGE", "WORLD_KNOWLEDGE"]},
      lastUpdatedAt: {:string, "date-time"},
      lastUpdatedBy: {Gleanex.Client.PersonObject, :t},
      logoUrl: :string,
      name: :string,
      objectName: :string,
      permissions: {Gleanex.Client.ObjectPermissions, :t},
      toolId: :string,
      type: {:enum, ["RETRIEVAL", "ACTION"]},
      usageInstructions: :string,
      writeActionType: {:enum, ["REDIRECT", "EXECUTION", "MCP"]}
    ]
  end
end
