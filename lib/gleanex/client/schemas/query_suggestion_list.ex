defmodule Gleanex.Client.QuerySuggestionList do
  @moduledoc """
  Provides struct and type for a QuerySuggestionList
  """

  @type t :: %__MODULE__{
          person: Gleanex.Client.Person.t() | nil,
          suggestions: [Gleanex.Client.QuerySuggestion.t()] | nil
        }

  defstruct [:person, :suggestions]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [person: {Gleanex.Client.Person, :t}, suggestions: [{Gleanex.Client.QuerySuggestion, :t}]]
  end
end
