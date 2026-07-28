defmodule Gleanex.Client.Group do
  @moduledoc """
  Provides struct and type for a Group
  """

  @type t :: %__MODULE__{
          datasourceInstance: String.t() | nil,
          id: String.t(),
          name: String.t() | nil,
          provisioningId: String.t() | nil,
          type: String.t()
        }

  defstruct [:datasourceInstance, :id, :name, :provisioningId, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      datasourceInstance: :string,
      id: :string,
      name: :string,
      provisioningId: :string,
      type:
        {:enum,
         [
           "DEPARTMENT",
           "ALL",
           "TEAM",
           "JOB_TITLE",
           "ROLE_TYPE",
           "LOCATION",
           "REGION",
           "EXTERNAL_GROUP",
           "COLLECTION_AUDIENCE"
         ]}
    ]
  end
end
