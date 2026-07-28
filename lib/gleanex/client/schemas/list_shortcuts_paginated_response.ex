defmodule Gleanex.Client.ListShortcutsPaginatedResponse do
  @moduledoc """
  Provides struct and type for a ListShortcutsPaginatedResponse
  """

  @type t :: %__MODULE__{
          facetResults: [Gleanex.Client.FacetResult.t()] | nil,
          meta: Gleanex.Client.ShortcutsPaginationMetadata.t(),
          shortcuts: [Gleanex.Client.Shortcut.t()]
        }

  defstruct [:facetResults, :meta, :shortcuts]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      facetResults: [{Gleanex.Client.FacetResult, :t}],
      meta: {Gleanex.Client.ShortcutsPaginationMetadata, :t},
      shortcuts: [{Gleanex.Client.Shortcut, :t}]
    ]
  end
end
