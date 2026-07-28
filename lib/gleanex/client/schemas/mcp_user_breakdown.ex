defmodule Gleanex.Client.McpUserBreakdown do
  @moduledoc """
  Provides struct and type for a McpUserBreakdown
  """

  @type t :: %__MODULE__{
          hostApplications: [String.t()] | nil,
          person: Gleanex.Client.Person.t() | nil,
          servers: [String.t()] | nil,
          tools: [String.t()] | nil,
          totalCalls: integer | nil
        }

  defstruct [:hostApplications, :person, :servers, :tools, :totalCalls]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      hostApplications: [:string],
      person: {Gleanex.Client.Person, :t},
      servers: [:string],
      tools: [:string],
      totalCalls: :integer
    ]
  end
end
