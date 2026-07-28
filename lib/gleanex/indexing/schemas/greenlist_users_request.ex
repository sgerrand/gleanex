defmodule Gleanex.Indexing.GreenlistUsersRequest do
  @moduledoc """
  Provides struct and type for a GreenlistUsersRequest
  """

  @type t :: %__MODULE__{datasource: String.t(), emails: [String.t()]}

  defstruct [:datasource, :emails]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [datasource: :string, emails: [string: "email"]]
  end
end
