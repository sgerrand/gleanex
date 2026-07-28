defmodule Gleanex.Client.McpServerBreakdown do
  @moduledoc """
  Provides struct and type for a McpServerBreakdown
  """

  @type t :: %__MODULE__{
          activeUsers: integer | nil,
          hostApplications: [String.t()] | nil,
          server: String.t() | nil,
          totalCalls: integer | nil
        }

  defstruct [:activeUsers, :hostApplications, :server, :totalCalls]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [activeUsers: :integer, hostApplications: [:string], server: :string, totalCalls: :integer]
  end
end
