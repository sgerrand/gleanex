defmodule Gleanex.Client.GetDocPermissionsRequest do
  @moduledoc """
  Provides struct and type for a GetDocPermissionsRequest
  """

  @type t :: %__MODULE__{documentId: String.t() | nil}

  defstruct [:documentId]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [documentId: :string]
  end
end
