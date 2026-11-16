defmodule Gleanex.Platform.Document do
  @moduledoc """
  Provides struct and type for a Document
  """

  @type t :: %__MODULE__{
          content: Gleanex.Platform.DocumentContent.t() | nil,
          created_at: DateTime.t() | nil,
          creator: Gleanex.Platform.PersonReference.t() | nil,
          datasource: String.t(),
          document_id: String.t(),
          document_type: String.t() | nil,
          mime_type: String.t() | nil,
          owner: Gleanex.Platform.PersonReference.t() | nil,
          title: String.t(),
          updated_at: DateTime.t() | nil,
          url: String.t()
        }

  defstruct [
    :content,
    :created_at,
    :creator,
    :datasource,
    :document_id,
    :document_type,
    :mime_type,
    :owner,
    :title,
    :updated_at,
    :url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      content: {Gleanex.Platform.DocumentContent, :t},
      created_at: {:union, [{:string, "date-time"}, :null]},
      creator: {Gleanex.Platform.PersonReference, :t},
      datasource: :string,
      document_id: :string,
      document_type: {:union, [:string, :null]},
      mime_type: :string,
      owner: {Gleanex.Platform.PersonReference, :t},
      title: :string,
      updated_at: {:union, [{:string, "date-time"}, :null]},
      url: {:string, "uri"}
    ]
  end
end
