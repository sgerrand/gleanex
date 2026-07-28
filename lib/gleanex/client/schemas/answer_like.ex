defmodule Gleanex.Client.AnswerLike do
  @moduledoc """
  Provides struct and type for a AnswerLike
  """

  @type t :: %__MODULE__{createTime: DateTime.t() | nil, user: Gleanex.Client.Person.t() | nil}

  defstruct [:createTime, :user]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [createTime: {:string, "date-time"}, user: {Gleanex.Client.Person, :t}]
  end
end
