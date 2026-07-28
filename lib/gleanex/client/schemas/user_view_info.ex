defmodule Gleanex.Client.UserViewInfo do
  @moduledoc """
  Provides struct and type for a UserViewInfo
  """

  @type t :: %__MODULE__{
          docId: String.t() | nil,
          docTitle: String.t() | nil,
          docUrl: String.t() | nil
        }

  defstruct [:docId, :docTitle, :docUrl]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [docId: :string, docTitle: :string, docUrl: :string]
  end
end
