defmodule Gleanex.Client.ResultTab do
  @moduledoc """
  Provides struct and type for a ResultTab
  """

  @type t :: %__MODULE__{
          count: integer | nil,
          datasource: String.t() | nil,
          datasourceInstance: String.t() | nil,
          id: String.t() | nil
        }

  defstruct [:count, :datasource, :datasourceInstance, :id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [count: :integer, datasource: :string, datasourceInstance: :string, id: :string]
  end
end
