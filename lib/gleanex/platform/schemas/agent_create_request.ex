defmodule Gleanex.Platform.AgentCreateRequest do
  @moduledoc """
  Provides struct and type for a AgentCreateRequest
  """

  @type t :: %__MODULE__{
          channels: Gleanex.Platform.AgentChannels.t() | nil,
          dependencies: [Gleanex.Platform.AgentDependency.t()] | nil,
          description: String.t() | nil,
          glean_search_config: Gleanex.Platform.AgentGleanSearchConfig.t() | nil,
          instructions: String.t() | nil,
          model: Gleanex.Platform.AgentLlmModel.t() | nil,
          name: String.t() | nil,
          service_credentials: [Gleanex.Platform.AgentServiceCredential.t()] | nil,
          skills: [Gleanex.Platform.AgentSkill.t()] | nil,
          subagents: [Gleanex.Platform.Subagent.t()] | nil,
          tools: [Gleanex.Platform.AgentToolset.t()] | nil,
          trigger: Gleanex.Platform.AgentTrigger.t() | nil,
          use_agent_identity: boolean | nil
        }

  defstruct [
    :channels,
    :dependencies,
    :description,
    :glean_search_config,
    :instructions,
    :model,
    :name,
    :service_credentials,
    :skills,
    :subagents,
    :tools,
    :trigger,
    :use_agent_identity
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      channels: {Gleanex.Platform.AgentChannels, :t},
      dependencies: [{Gleanex.Platform.AgentDependency, :t}],
      description: :string,
      glean_search_config: {Gleanex.Platform.AgentGleanSearchConfig, :t},
      instructions: :string,
      model: {Gleanex.Platform.AgentLlmModel, :t},
      name: :string,
      service_credentials: [{Gleanex.Platform.AgentServiceCredential, :t}],
      skills: [{Gleanex.Platform.AgentSkill, :t}],
      subagents: [{Gleanex.Platform.Subagent, :t}],
      tools: [{Gleanex.Platform.AgentToolset, :t}],
      trigger: {Gleanex.Platform.AgentTrigger, :t},
      use_agent_identity: :boolean
    ]
  end
end
