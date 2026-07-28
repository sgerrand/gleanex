defmodule Gleanex.Client.FeedRequestOptions do
  @moduledoc """
  Provides struct and type for a FeedRequestOptions
  """

  @type t :: %__MODULE__{
          categoryToResultSize: map | nil,
          chatZeroStateSuggestionOptions: Gleanex.Client.ChatZeroStateSuggestionOptions.t() | nil,
          datasourceFilter: [String.t()] | nil,
          resultSize: integer,
          timezoneOffset: integer | nil
        }

  defstruct [
    :categoryToResultSize,
    :chatZeroStateSuggestionOptions,
    :datasourceFilter,
    :resultSize,
    :timezoneOffset
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      categoryToResultSize: :map,
      chatZeroStateSuggestionOptions: {Gleanex.Client.ChatZeroStateSuggestionOptions, :t},
      datasourceFilter: [:string],
      resultSize: :integer,
      timezoneOffset: :integer
    ]
  end
end
