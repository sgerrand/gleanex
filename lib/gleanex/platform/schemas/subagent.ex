defmodule Gleanex.Platform.Subagent do
  @moduledoc """
  Provides struct and type for a Subagent
  """

  @type t :: %__MODULE__{
          dependencies: [Gleanex.Platform.AgentDependency.t()] | nil,
          description: String.t() | nil,
          glean_search_config: Gleanex.Platform.AgentGleanSearchConfig.t() | nil,
          instructions: String.t() | nil,
          model: Gleanex.Platform.AgentLlmModel.t() | nil,
          name: String.t() | nil,
          service_credentials: [Gleanex.Platform.AgentServiceCredential.t()] | nil,
          skills: [Gleanex.Platform.AgentSkill.t()] | nil,
          subagent_id: String.t() | nil,
          tools: [Gleanex.Platform.AgentToolset.t()] | nil
        }

  defstruct [
    :dependencies,
    :description,
    :glean_search_config,
    :instructions,
    :model,
    :name,
    :service_credentials,
    :skills,
    :subagent_id,
    :tools
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      dependencies: [{Gleanex.Platform.AgentDependency, :t}],
      description: :string,
      glean_search_config: {Gleanex.Platform.AgentGleanSearchConfig, :t},
      instructions: :string,
      model: {Gleanex.Platform.AgentLlmModel, :t},
      name: :string,
      service_credentials: [{Gleanex.Platform.AgentServiceCredential, :t}],
      skills: [{Gleanex.Platform.AgentSkill, :t}],
      subagent_id: :string,
      tools: [{Gleanex.Platform.AgentToolset, :t}]
    ]
  end
end
