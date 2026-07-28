defmodule Gleanex.Indexing.DebugDocumentResponse do
  @moduledoc """
  Provides struct and type for a DebugDocumentResponse
  """

  @type t :: %__MODULE__{
          status: Gleanex.Indexing.DocumentStatusResponse.t() | nil,
          uploadedPermissions: Gleanex.Indexing.DocumentPermissionsDefinition.t() | nil
        }

  defstruct [:status, :uploadedPermissions]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      status: {Gleanex.Indexing.DocumentStatusResponse, :t},
      uploadedPermissions: {Gleanex.Indexing.DocumentPermissionsDefinition, :t}
    ]
  end
end
