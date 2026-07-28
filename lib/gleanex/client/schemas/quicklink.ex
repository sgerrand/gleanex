defmodule Gleanex.Client.Quicklink do
  @moduledoc """
  Provides struct and type for a Quicklink
  """

  @type t :: %__MODULE__{
          iconConfig: Gleanex.Client.IconConfig.t() | nil,
          id: String.t() | nil,
          name: String.t() | nil,
          scopes: [String.t()] | nil,
          shortName: String.t() | nil,
          url: String.t() | nil
        }

  defstruct [:iconConfig, :id, :name, :scopes, :shortName, :url]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      iconConfig: {Gleanex.Client.IconConfig, :t},
      id: :string,
      name: :string,
      scopes: [
        enum: [
          "APP_CARD",
          "AUTOCOMPLETE_EXACT_MATCH",
          "AUTOCOMPLETE_FUZZY_MATCH",
          "AUTOCOMPLETE_ZERO_QUERY",
          "NEW_TAB_PAGE"
        ]
      ],
      shortName: :string,
      url: :string
    ]
  end
end
