defmodule Gleanex.Client.ClusterGroup do
  @moduledoc """
  Provides struct and type for a ClusterGroup
  """

  @type t :: %__MODULE__{
          clusterType: String.t() | nil,
          clusteredResults: [Gleanex.Client.SearchResult.t()] | nil,
          visibleCountHint: integer
        }

  defstruct [:clusterType, :clusteredResults, :visibleCountHint]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      clusterType:
        {:enum,
         [
           "SIMILAR",
           "FRESHNESS",
           "TITLE",
           "CONTENT",
           "NONE",
           "THREAD_REPLY",
           "THREAD_ROOT",
           "PREFIX",
           "SUFFIX",
           "AUTHOR_PREFIX",
           "AUTHOR_SUFFIX"
         ]},
      clusteredResults: [{Gleanex.Client.SearchResult, :t}],
      visibleCountHint: :integer
    ]
  end
end
