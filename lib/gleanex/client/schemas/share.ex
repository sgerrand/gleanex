defmodule Gleanex.Client.Share do
  @moduledoc """
  Provides struct and type for a Share
  """

  @type t :: %__MODULE__{
          numDaysAgo: integer,
          sharer: Gleanex.Client.Person.t() | nil,
          sharingDocument: Gleanex.Client.Document.t() | nil
        }

  defstruct [:numDaysAgo, :sharer, :sharingDocument]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      numDaysAgo: :integer,
      sharer: {Gleanex.Client.Person, :t},
      sharingDocument: {Gleanex.Client.Document, :t}
    ]
  end
end
