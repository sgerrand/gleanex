defmodule Gleanex.Client.McpAuthMethodBreakdown do
  @moduledoc """
  Provides struct and type for a McpAuthMethodBreakdown
  """

  @type t :: %__MODULE__{
          activeUsers: integer | nil,
          authMethod: String.t() | nil,
          hostApplications: [String.t()] | nil,
          totalCalls: integer | nil
        }

  defstruct [:activeUsers, :authMethod, :hostApplications, :totalCalls]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      activeUsers: :integer,
      authMethod: :string,
      hostApplications: [:string],
      totalCalls: :integer
    ]
  end
end
