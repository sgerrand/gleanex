defmodule Gleanex.Indexing.DebugUserResponse do
  @moduledoc """
  Provides struct and type for a DebugUserResponse
  """

  @type t :: %__MODULE__{
          status: Gleanex.Indexing.UserStatusResponse.t() | nil,
          uploadedGroups: [Gleanex.Indexing.DatasourceGroupDefinition.t()] | nil
        }

  defstruct [:status, :uploadedGroups]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      status: {Gleanex.Indexing.UserStatusResponse, :t},
      uploadedGroups: [{Gleanex.Indexing.DatasourceGroupDefinition, :t}]
    ]
  end
end
