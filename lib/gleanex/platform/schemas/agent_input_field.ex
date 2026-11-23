defmodule Gleanex.Platform.AgentInputField do
  @moduledoc """
  Provides struct and type for a AgentInputField
  """

  @type t :: %__MODULE__{
          default_value: String.t() | nil,
          description: String.t() | nil,
          display_name: String.t(),
          is_optional: boolean | nil,
          options: [Gleanex.Platform.AgentInputFieldOption.t()] | nil,
          type: String.t()
        }

  defstruct [:default_value, :description, :display_name, :is_optional, :options, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      default_value: :string,
      description: :string,
      display_name: :string,
      is_optional: :boolean,
      options: [{Gleanex.Platform.AgentInputFieldOption, :t}],
      type: {:enum, ["TEXT", "SELECT", "DATE", "DOCUMENT"]}
    ]
  end
end
