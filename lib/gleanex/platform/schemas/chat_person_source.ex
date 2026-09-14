defmodule Gleanex.Platform.ChatPersonSource do
  @moduledoc """
  Provides struct and type for a ChatPersonSource
  """

  @type t :: %__MODULE__{
          name: String.t() | nil,
          person_id: String.t(),
          type: String.t(),
          url: String.t() | nil
        }

  defstruct [:name, :person_id, :type, :url]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [name: :string, person_id: :string, type: {:const, "PERSON"}, url: :string]
  end
end
