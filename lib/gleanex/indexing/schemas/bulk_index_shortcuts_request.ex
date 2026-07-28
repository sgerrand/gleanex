defmodule Gleanex.Indexing.BulkIndexShortcutsRequest do
  @moduledoc """
  Provides struct and type for a BulkIndexShortcutsRequest
  """

  @type t :: %__MODULE__{
          forceRestartUpload: boolean | nil,
          isFirstPage: boolean | nil,
          isLastPage: boolean | nil,
          shortcuts: [Gleanex.Indexing.ExternalShortcut.t()] | nil,
          uploadId: String.t() | nil
        }

  defstruct [:forceRestartUpload, :isFirstPage, :isLastPage, :shortcuts, :uploadId]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      forceRestartUpload: :boolean,
      isFirstPage: :boolean,
      isLastPage: :boolean,
      shortcuts: [{Gleanex.Indexing.ExternalShortcut, :t}],
      uploadId: :string
    ]
  end
end
