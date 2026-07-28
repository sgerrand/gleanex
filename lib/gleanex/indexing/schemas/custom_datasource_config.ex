defmodule Gleanex.Indexing.CustomDatasourceConfig do
  @moduledoc """
  Provides struct and type for a CustomDatasourceConfig
  """

  @type t :: %__MODULE__{
          aliases: [String.t()] | nil,
          canonicalizingTitleRegex: [Gleanex.Indexing.CanonicalizingRegexType.t()] | nil,
          canonicalizingURLRegex: [Gleanex.Indexing.CanonicalizingRegexType.t()] | nil,
          connectorType: String.t() | nil,
          crawlerSeedUrls: [String.t()] | nil,
          datasourceCategory: String.t() | nil,
          displayName: String.t() | nil,
          hideBuiltInFacets: [String.t()] | nil,
          homeUrl: String.t() | nil,
          iconDarkUrl: String.t() | nil,
          iconUrl: String.t() | nil,
          identityDatasourceName: String.t() | nil,
          includeUtmSource: boolean | nil,
          isEntityDatasource: boolean | nil,
          isOnPrem: boolean | nil,
          isTestDatasource: boolean | nil,
          isUserReferencedByEmail: boolean | nil,
          name: String.t() | nil,
          objectDefinitions: [Gleanex.Indexing.ObjectDefinition.t()] | nil,
          productAccessGroup: String.t() | nil,
          quicklinks: [Gleanex.Indexing.Quicklink.t()] | nil,
          redlistTitleRegex: String.t() | nil,
          renderConfigPreset: String.t() | nil,
          stripFragmentInCanonicalUrl: boolean | nil,
          suggestionText: String.t() | nil,
          trustUrlRegexForViewActivity: boolean | nil,
          urlRegex: String.t() | nil
        }

  defstruct [
    :aliases,
    :canonicalizingTitleRegex,
    :canonicalizingURLRegex,
    :connectorType,
    :crawlerSeedUrls,
    :datasourceCategory,
    :displayName,
    :hideBuiltInFacets,
    :homeUrl,
    :iconDarkUrl,
    :iconUrl,
    :identityDatasourceName,
    :includeUtmSource,
    :isEntityDatasource,
    :isOnPrem,
    :isTestDatasource,
    :isUserReferencedByEmail,
    :name,
    :objectDefinitions,
    :productAccessGroup,
    :quicklinks,
    :redlistTitleRegex,
    :renderConfigPreset,
    :stripFragmentInCanonicalUrl,
    :suggestionText,
    :trustUrlRegexForViewActivity,
    :urlRegex
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      aliases: [:string],
      canonicalizingTitleRegex: [{Gleanex.Indexing.CanonicalizingRegexType, :t}],
      canonicalizingURLRegex: [{Gleanex.Indexing.CanonicalizingRegexType, :t}],
      connectorType: :string,
      crawlerSeedUrls: [:string],
      datasourceCategory:
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
      displayName: :string,
      hideBuiltInFacets: [enum: ["TYPE", "TAG", "AUTHOR", "OWNER"]],
      homeUrl: :string,
      iconDarkUrl: :string,
      iconUrl: :string,
      identityDatasourceName: :string,
      includeUtmSource: :boolean,
      isEntityDatasource: :boolean,
      isOnPrem: :boolean,
      isTestDatasource: :boolean,
      isUserReferencedByEmail: :boolean,
      name: :string,
      objectDefinitions: [{Gleanex.Indexing.ObjectDefinition, :t}],
      productAccessGroup: :string,
      quicklinks: [{Gleanex.Indexing.Quicklink, :t}],
      redlistTitleRegex: :string,
      renderConfigPreset: :string,
      stripFragmentInCanonicalUrl: :boolean,
      suggestionText: :string,
      trustUrlRegexForViewActivity: :boolean,
      urlRegex: :string
    ]
  end
end
