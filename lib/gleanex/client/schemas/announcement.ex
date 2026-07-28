defmodule Gleanex.Client.Announcement do
  @moduledoc """
  Provides struct and type for a Announcement
  """

  @type t :: %__MODULE__{
          audienceFilters: [Gleanex.Client.FacetFilter.t()] | nil,
          author: Gleanex.Client.Person.t() | nil,
          banner: Gleanex.Client.Thumbnail.t() | nil,
          body: Gleanex.Client.StructuredText.t() | nil,
          channel: String.t() | nil,
          createTimestamp: integer | nil,
          draftId: integer | nil,
          emoji: String.t() | nil,
          endTime: DateTime.t() | nil,
          favoriteInfo: Gleanex.Client.FavoriteInfo.t() | nil,
          hideAttribution: boolean | nil,
          id: integer | nil,
          isPrioritized: boolean | nil,
          isPublished: boolean | nil,
          lastUpdateTimestamp: integer | nil,
          permissions: Gleanex.Client.ObjectPermissions.t() | nil,
          postType: String.t() | nil,
          sourceDocument: Gleanex.Client.Document.t() | nil,
          sourceDocumentId: String.t() | nil,
          startTime: DateTime.t() | nil,
          thumbnail: Gleanex.Client.Thumbnail.t() | nil,
          title: String.t() | nil,
          trackingToken: String.t() | nil,
          updatedBy: Gleanex.Client.Person.t() | nil,
          viewUrl: String.t() | nil,
          viewerInfo: Gleanex.Client.AnnouncementViewerInfo.t() | nil
        }

  defstruct [
    :audienceFilters,
    :author,
    :banner,
    :body,
    :channel,
    :createTimestamp,
    :draftId,
    :emoji,
    :endTime,
    :favoriteInfo,
    :hideAttribution,
    :id,
    :isPrioritized,
    :isPublished,
    :lastUpdateTimestamp,
    :permissions,
    :postType,
    :sourceDocument,
    :sourceDocumentId,
    :startTime,
    :thumbnail,
    :title,
    :trackingToken,
    :updatedBy,
    :viewUrl,
    :viewerInfo
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      audienceFilters: [{Gleanex.Client.FacetFilter, :t}],
      author: {Gleanex.Client.Person, :t},
      banner: {Gleanex.Client.Thumbnail, :t},
      body: {Gleanex.Client.StructuredText, :t},
      channel: {:enum, ["MAIN", "SOCIAL_FEED"]},
      createTimestamp: :integer,
      draftId: :integer,
      emoji: :string,
      endTime: {:string, "date-time"},
      favoriteInfo: {Gleanex.Client.FavoriteInfo, :t},
      hideAttribution: :boolean,
      id: :integer,
      isPrioritized: :boolean,
      isPublished: :boolean,
      lastUpdateTimestamp: :integer,
      permissions: {Gleanex.Client.ObjectPermissions, :t},
      postType: {:enum, ["TEXT", "LINK"]},
      sourceDocument: {Gleanex.Client.Document, :t},
      sourceDocumentId: :string,
      startTime: {:string, "date-time"},
      thumbnail: {Gleanex.Client.Thumbnail, :t},
      title: :string,
      trackingToken: :string,
      updatedBy: {Gleanex.Client.Person, :t},
      viewUrl: :string,
      viewerInfo: {Gleanex.Client.AnnouncementViewerInfo, :t}
    ]
  end
end
