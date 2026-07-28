defmodule Gleanex.Client.DeleteAnswerRequest do
  @moduledoc """
  Provides struct and type for a DeleteAnswerRequest
  """

  @type t :: %__MODULE__{docId: String.t() | nil, id: integer | nil}

  defstruct [:docId, :id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [docId: :string, id: :integer]
  end
end
