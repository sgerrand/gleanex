defmodule Gleanex.Client.CreateCollectionRequest do
  @moduledoc """
  Provides struct and type for a CreateCollectionRequest
  """

  @type t :: %__MODULE__{newNextItemId: String.t() | nil}

  defstruct [:newNextItemId]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [newNextItemId: :string]
  end
end
