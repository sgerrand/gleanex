defmodule Gleanex.Client.GetDocumentsRequest do
  @moduledoc """
  Provides struct and type for a GetDocumentsRequest
  """

  @type t :: %__MODULE__{documentSpecs: [map], includeFields: [String.t()] | nil}

  defstruct [:documentSpecs, :includeFields]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      documentSpecs: [:map],
      includeFields: [
        enum: [
          "LAST_VIEWED_AT",
          "VISITORS_COUNT",
          "RECENT_SHARES",
          "DOCUMENT_CONTENT",
          "CUSTOM_METADATA"
        ]
      ]
    ]
  end
end
