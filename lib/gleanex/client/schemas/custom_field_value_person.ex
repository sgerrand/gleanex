defmodule Gleanex.Client.CustomFieldValuePerson do
  @moduledoc """
  Provides struct and type for a CustomFieldValuePerson
  """

  @type t :: %__MODULE__{person: Gleanex.Client.Person.t() | nil}

  defstruct [:person]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [person: {Gleanex.Client.Person, :t}]
  end
end
