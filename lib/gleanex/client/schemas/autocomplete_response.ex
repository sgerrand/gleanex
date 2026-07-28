defmodule Gleanex.Client.AutocompleteResponse do
  @moduledoc """
  Provides struct and type for a AutocompleteResponse
  """

  @type t :: %__MODULE__{
          backendTimeMillis: integer | nil,
          errorInfo: Gleanex.Client.ErrorInfo.t() | nil,
          experimentIds: [integer] | nil,
          groups: [Gleanex.Client.AutocompleteResultGroup.t()] | nil,
          results: [Gleanex.Client.AutocompleteResult.t()] | nil,
          sessionInfo: Gleanex.Client.SessionInfo.t() | nil,
          trackingToken: String.t() | nil
        }

  defstruct [
    :backendTimeMillis,
    :errorInfo,
    :experimentIds,
    :groups,
    :results,
    :sessionInfo,
    :trackingToken
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      backendTimeMillis: {:integer, "int64"},
      errorInfo: {Gleanex.Client.ErrorInfo, :t},
      experimentIds: [integer: "int64"],
      groups: [{Gleanex.Client.AutocompleteResultGroup, :t}],
      results: [{Gleanex.Client.AutocompleteResult, :t}],
      sessionInfo: {Gleanex.Client.SessionInfo, :t},
      trackingToken: :string
    ]
  end
end
