defmodule Gleanex.Client.McpHostApplicationBreakdown do
  @moduledoc """
  Provides struct and type for a McpHostApplicationBreakdown
  """

  @type t :: %__MODULE__{
          activeUsers: integer | nil,
          hostApplication: String.t() | nil,
          totalCalls: integer | nil
        }

  defstruct [:activeUsers, :hostApplication, :totalCalls]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [activeUsers: :integer, hostApplication: :string, totalCalls: :integer]
  end
end
