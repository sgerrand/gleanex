defmodule Gleanex.Platform.ChatCustomEntitySource do
  @moduledoc """
  Provides struct and type for a ChatCustomEntitySource
  """

  @type t :: %__MODULE__{
          datasource: String.t() | nil,
          entity_id: String.t(),
          name: String.t() | nil,
          title: String.t() | nil,
          type: String.t(),
          url: String.t() | nil
        }

  defstruct [:datasource, :entity_id, :name, :title, :type, :url]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      datasource: :string,
      entity_id: :string,
      name: :string,
      title: :string,
      type: {:const, "custom_entity"},
      url: :string
    ]
  end
end
