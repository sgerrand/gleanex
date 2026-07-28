defmodule Gleanex.Client.Reaction do
  @moduledoc """
  Provides struct and type for a Reaction
  """

  @type t :: %__MODULE__{
          count: integer | nil,
          reactedByViewer: boolean | nil,
          reactors: [Gleanex.Client.Person.t()] | nil,
          type: String.t() | nil
        }

  defstruct [:count, :reactedByViewer, :reactors, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      count: :integer,
      reactedByViewer: :boolean,
      reactors: [{Gleanex.Client.Person, :t}],
      type: :string
    ]
  end
end
