defmodule Gleanex.Client.CreateAnnouncementRequest do
  @moduledoc """
  Provides struct and type for a CreateAnnouncementRequest
  """

  @type t :: %__MODULE__{
          audienceFilters: [Gleanex.Client.FacetFilter.t()] | nil,
          banner: Gleanex.Client.Thumbnail.t() | nil,
          body: Gleanex.Client.StructuredText.t() | nil,
          channel: String.t() | nil,
          emoji: String.t() | nil,
          endTime: DateTime.t() | nil,
          hideAttribution: boolean | nil,
          isPrioritized: boolean | nil,
          postType: String.t() | nil,
          sourceDocumentId: String.t() | nil,
          startTime: DateTime.t() | nil,
          thumbnail: Gleanex.Client.Thumbnail.t() | nil,
          title: String.t() | nil,
          viewUrl: String.t() | nil
        }

  defstruct [
    :audienceFilters,
    :banner,
    :body,
    :channel,
    :emoji,
    :endTime,
    :hideAttribution,
    :isPrioritized,
    :postType,
    :sourceDocumentId,
    :startTime,
    :thumbnail,
    :title,
    :viewUrl
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      audienceFilters: [{Gleanex.Client.FacetFilter, :t}],
      banner: {Gleanex.Client.Thumbnail, :t},
      body: {Gleanex.Client.StructuredText, :t},
      channel: {:enum, ["MAIN", "SOCIAL_FEED"]},
      emoji: :string,
      endTime: {:string, "date-time"},
      hideAttribution: :boolean,
      isPrioritized: :boolean,
      postType: {:enum, ["TEXT", "LINK"]},
      sourceDocumentId: :string,
      startTime: {:string, "date-time"},
      thumbnail: {Gleanex.Client.Thumbnail, :t},
      title: :string,
      viewUrl: :string
    ]
  end
end
