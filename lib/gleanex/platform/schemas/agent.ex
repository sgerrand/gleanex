defmodule Gleanex.Platform.Agent do
  @moduledoc """
  Provides struct and type for a Agent
  """

  @type t :: %__MODULE__{
          agent_id: String.t() | nil,
          capabilities: Gleanex.Platform.AgentCapabilities.t() | nil,
          channels: Gleanex.Platform.AgentChannels.t() | nil,
          created_at: DateTime.t() | nil,
          created_by: Gleanex.Platform.PersonReference.t() | nil,
          dependencies: [Gleanex.Platform.AgentDependency.t()] | nil,
          description: String.t() | nil,
          glean_search_config: Gleanex.Platform.AgentGleanSearchConfig.t() | nil,
          instructions: String.t() | nil,
          metadata: map | nil,
          model: Gleanex.Platform.AgentLlmModel.t() | nil,
          name: String.t() | nil,
          service_credentials: [Gleanex.Platform.AgentServiceCredential.t()] | nil,
          skills: [Gleanex.Platform.AgentSkill.t()] | nil,
          subagents: [Gleanex.Platform.Subagent.t()] | nil,
          tools: [Gleanex.Platform.AgentToolset.t()] | nil,
          trigger: Gleanex.Platform.AgentTrigger.t() | nil,
          updated_at: DateTime.t() | nil,
          updated_by: Gleanex.Platform.PersonReference.t() | nil,
          use_agent_identity: boolean | nil
        }

  defstruct [
    :agent_id,
    :capabilities,
    :channels,
    :created_at,
    :created_by,
    :dependencies,
    :description,
    :glean_search_config,
    :instructions,
    :metadata,
    :model,
    :name,
    :service_credentials,
    :skills,
    :subagents,
    :tools,
    :trigger,
    :updated_at,
    :updated_by,
    :use_agent_identity
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      agent_id: :string,
      capabilities: {Gleanex.Platform.AgentCapabilities, :t},
      channels: {Gleanex.Platform.AgentChannels, :t},
      created_at: {:string, "date-time"},
      created_by: {Gleanex.Platform.PersonReference, :t},
      dependencies: [{Gleanex.Platform.AgentDependency, :t}],
      description: :string,
      glean_search_config: {Gleanex.Platform.AgentGleanSearchConfig, :t},
      instructions: :string,
      metadata: :map,
      model: {Gleanex.Platform.AgentLlmModel, :t},
      name: :string,
      service_credentials: [{Gleanex.Platform.AgentServiceCredential, :t}],
      skills: [{Gleanex.Platform.AgentSkill, :t}],
      subagents: [{Gleanex.Platform.Subagent, :t}],
      tools: [{Gleanex.Platform.AgentToolset, :t}],
      trigger: {Gleanex.Platform.AgentTrigger, :t},
      updated_at: {:string, "date-time"},
      updated_by: {Gleanex.Platform.PersonReference, :t},
      use_agent_identity: :boolean
    ]
  end
end
