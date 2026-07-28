defmodule Gleanex.Client.CountInfo do
  @moduledoc """
  Provides struct and type for a CountInfo
  """

  @type t :: %__MODULE__{
          count: integer,
          org: String.t() | nil,
          period: Gleanex.Client.Period.t() | nil
        }

  defstruct [:count, :org, :period]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [count: :integer, org: :string, period: {Gleanex.Client.Period, :t}]
  end
end
