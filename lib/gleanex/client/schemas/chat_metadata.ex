defmodule Gleanex.Client.ChatMetadata do
  @moduledoc """
  Provides struct and type for a ChatMetadata
  """

  @type t :: %__MODULE__{
          applicationId: String.t() | nil,
          applicationName: String.t() | nil,
          createTime: integer | nil,
          createdBy: Gleanex.Client.Person.t() | nil,
          icon: Gleanex.Client.IconConfig.t() | nil,
          id: String.t() | nil,
          name: String.t() | nil,
          updateTime: integer | nil
        }

  defstruct [
    :applicationId,
    :applicationName,
    :createTime,
    :createdBy,
    :icon,
    :id,
    :name,
    :updateTime
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      applicationId: :string,
      applicationName: :string,
      createTime: :integer,
      createdBy: {Gleanex.Client.Person, :t},
      icon: {Gleanex.Client.IconConfig, :t},
      id: :string,
      name: :string,
      updateTime: :integer
    ]
  end
end
