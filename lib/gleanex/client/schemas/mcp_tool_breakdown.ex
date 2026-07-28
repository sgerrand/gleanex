defmodule Gleanex.Client.McpToolBreakdown do
  @moduledoc """
  Provides struct and type for a McpToolBreakdown
  """

  @type t :: %__MODULE__{
          activeUsers: integer | nil,
          hostApplications: [String.t()] | nil,
          tool: String.t() | nil,
          totalCalls: integer | nil
        }

  defstruct [:activeUsers, :hostApplications, :tool, :totalCalls]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [activeUsers: :integer, hostApplications: [:string], tool: :string, totalCalls: :integer]
  end
end
