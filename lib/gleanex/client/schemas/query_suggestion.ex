defmodule Gleanex.Client.QuerySuggestion do
  @moduledoc """
  Provides struct and type for a QuerySuggestion
  """

  @type t :: %__MODULE__{
          datasource: String.t() | nil,
          inputDetails: Gleanex.Client.SearchRequestInputDetails.t() | nil,
          label: String.t() | nil,
          missingTerm: String.t() | nil,
          query: String.t(),
          ranges: [Gleanex.Client.TextRange.t()] | nil,
          requestOptions: Gleanex.Client.SearchRequestOptions.t() | nil,
          resultTab: Gleanex.Client.ResultTab.t() | nil,
          searchProviderInfo: Gleanex.Client.SearchProviderInfo.t() | nil
        }

  defstruct [
    :datasource,
    :inputDetails,
    :label,
    :missingTerm,
    :query,
    :ranges,
    :requestOptions,
    :resultTab,
    :searchProviderInfo
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      datasource: :string,
      inputDetails: {Gleanex.Client.SearchRequestInputDetails, :t},
      label: :string,
      missingTerm: :string,
      query: :string,
      ranges: [{Gleanex.Client.TextRange, :t}],
      requestOptions: {Gleanex.Client.SearchRequestOptions, :t},
      resultTab: {Gleanex.Client.ResultTab, :t},
      searchProviderInfo: {Gleanex.Client.SearchProviderInfo, :t}
    ]
  end
end
