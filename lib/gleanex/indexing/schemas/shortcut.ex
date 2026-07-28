defmodule Gleanex.Indexing.Shortcut do
  @moduledoc """
  Provides struct and type for a Shortcut
  """

  @type t :: %__MODULE__{
          createTime: integer | nil,
          createdBy: String.t() | nil,
          description: String.t() | nil,
          destinationUrl: String.t() | nil,
          inputAlias: String.t() | nil,
          updateTime: integer | nil,
          updatedBy: String.t() | nil
        }

  defstruct [
    :createTime,
    :createdBy,
    :description,
    :destinationUrl,
    :inputAlias,
    :updateTime,
    :updatedBy
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      createTime: {:integer, "int64"},
      createdBy: :string,
      description: :string,
      destinationUrl: {:string, "url"},
      inputAlias: :string,
      updateTime: {:integer, "int64"},
      updatedBy: :string
    ]
  end
end
