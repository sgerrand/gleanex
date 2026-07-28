defmodule Gleanex.Client.IconConfig do
  @moduledoc """
  Provides struct and type for a IconConfig
  """

  @type t :: %__MODULE__{
          backgroundColor: String.t() | nil,
          color: String.t() | nil,
          generatedBackgroundColorKey: String.t() | nil,
          iconType: String.t() | nil,
          key: String.t() | nil,
          masked: boolean | nil,
          name: String.t() | nil,
          url: String.t() | nil
        }

  defstruct [
    :backgroundColor,
    :color,
    :generatedBackgroundColorKey,
    :iconType,
    :key,
    :masked,
    :name,
    :url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      backgroundColor: :string,
      color: :string,
      generatedBackgroundColorKey: :string,
      iconType:
        {:enum,
         [
           "COLLECTION",
           "CUSTOM",
           "DATASOURCE",
           "DATASOURCE_INSTANCE",
           "FAVICON",
           "FILE_TYPE",
           "GENERATED_BACKGROUND",
           "GLYPH",
           "MIME_TYPE",
           "NO_ICON",
           "PERSON",
           "REACTIONS",
           "URL"
         ]},
      key: :string,
      masked: :boolean,
      name: :string,
      url: :string
    ]
  end
end
