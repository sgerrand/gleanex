defmodule Gleanex.Client.PeopleResponse do
  @moduledoc """
  Provides struct and type for a PeopleResponse
  """

  @type t :: %__MODULE__{
          errors: [String.t()] | nil,
          relatedDocuments: [Gleanex.Client.RelatedDocuments.t()] | nil,
          results: [Gleanex.Client.Person.t()] | nil
        }

  defstruct [:errors, :relatedDocuments, :results]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      errors: [:string],
      relatedDocuments: [{Gleanex.Client.RelatedDocuments, :t}],
      results: [{Gleanex.Client.Person, :t}]
    ]
  end
end
