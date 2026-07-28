defmodule Gleanex.Client.AutocompleteRequest do
  @moduledoc """
  Provides struct and type for a AutocompleteRequest
  """

  @type t :: %__MODULE__{
          authTokens: [Gleanex.Client.AuthToken.t()] | nil,
          datasource: String.t() | nil,
          datasourcesFilter: [String.t()] | nil,
          query: String.t() | nil,
          resultSize: integer | nil,
          resultTypes: [String.t()] | nil,
          sessionInfo: Gleanex.Client.SessionInfo.t() | nil,
          trackingToken: String.t() | nil
        }

  defstruct [
    :authTokens,
    :datasource,
    :datasourcesFilter,
    :query,
    :resultSize,
    :resultTypes,
    :sessionInfo,
    :trackingToken
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      authTokens: [{Gleanex.Client.AuthToken, :t}],
      datasource: :string,
      datasourcesFilter: [:string],
      query: :string,
      resultSize: :integer,
      resultTypes: [
        enum: [
          "ADDITIONAL_DOCUMENT",
          "APP",
          "BROWSER_HISTORY",
          "DATASOURCE",
          "DOCUMENT",
          "ENTITY",
          "GOLINK",
          "HISTORY",
          "CHAT_HISTORY",
          "NEW_CHAT",
          "OPERATOR",
          "OPERATOR_VALUE",
          "QUICKLINK",
          "SUGGESTION"
        ]
      ],
      sessionInfo: {Gleanex.Client.SessionInfo, :t},
      trackingToken: :string
    ]
  end
end
