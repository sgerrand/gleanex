defmodule Gleanex.Indexing.DeleteGroupRequest do
  @moduledoc """
  Provides struct and type for a DeleteGroupRequest
  """

  @type t :: %__MODULE__{datasource: String.t(), groupName: String.t(), version: integer | nil}

  defstruct [:datasource, :groupName, :version]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [datasource: :string, groupName: :string, version: {:integer, "int64"}]
  end
end
