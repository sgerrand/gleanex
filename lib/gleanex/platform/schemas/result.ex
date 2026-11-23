defmodule Gleanex.Platform.Result do
  @moduledoc """
  Provides struct and type for a Result
  """

  @type t :: %__MODULE__{
          created_at: DateTime.t() | nil,
          creator: Gleanex.Platform.PersonReference.t() | nil,
          datasource: String.t(),
          document_type: String.t() | nil,
          owner: Gleanex.Platform.PersonReference.t() | nil,
          snippets: [String.t()] | nil,
          title: String.t(),
          updated_at: DateTime.t() | nil,
          url: String.t()
        }

  defstruct [
    :created_at,
    :creator,
    :datasource,
    :document_type,
    :owner,
    :snippets,
    :title,
    :updated_at,
    :url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      created_at: {:union, [{:string, "date-time"}, :null]},
      creator: {Gleanex.Platform.PersonReference, :t},
      datasource: :string,
      document_type: {:union, [:string, :null]},
      owner: {Gleanex.Platform.PersonReference, :t},
      snippets: [:string],
      title: :string,
      updated_at: {:union, [{:string, "date-time"}, :null]},
      url: {:string, "uri"}
    ]
  end
end
