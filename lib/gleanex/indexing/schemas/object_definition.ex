defmodule Gleanex.Indexing.ObjectDefinition do
  @moduledoc """
  Provides struct and type for a ObjectDefinition
  """

  @type t :: %__MODULE__{
          displayLabel: String.t() | nil,
          docCategory: String.t() | nil,
          name: String.t() | nil,
          propertyDefinitions: [Gleanex.Indexing.PropertyDefinition.t()] | nil,
          propertyGroups: [Gleanex.Indexing.PropertyGroup.t()] | nil,
          summarizable: boolean | nil
        }

  defstruct [
    :displayLabel,
    :docCategory,
    :name,
    :propertyDefinitions,
    :propertyGroups,
    :summarizable
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      displayLabel: :string,
      docCategory:
        {:enum,
         [
           "UNCATEGORIZED",
           "TICKETS",
           "CRM",
           "PUBLISHED_CONTENT",
           "COLLABORATIVE_CONTENT",
           "QUESTION_ANSWER",
           "MESSAGING",
           "CODE_REPOSITORY",
           "CHANGE_MANAGEMENT",
           "PEOPLE",
           "EMAIL",
           "SSO",
           "ATS",
           "KNOWLEDGE_HUB",
           "EXTERNAL_SHORTCUT",
           "ENTITY",
           "CALENDAR",
           "AGENTS",
           "AI_CONVERSATION",
           "AI_ARTIFACT"
         ]},
      name: :string,
      propertyDefinitions: [{Gleanex.Indexing.PropertyDefinition, :t}],
      propertyGroups: [{Gleanex.Indexing.PropertyGroup, :t}],
      summarizable: :boolean
    ]
  end
end
