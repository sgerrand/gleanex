defmodule Gleanex.Indexing.DebugDatasourceStatusIdentityResponseComponentCounts do
  @moduledoc """
  Provides struct and type for a DebugDatasourceStatusIdentityResponseComponentCounts
  """

  @type t :: %__MODULE__{uploaded: integer | nil}

  defstruct [:uploaded]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [uploaded: :integer]
  end
end
