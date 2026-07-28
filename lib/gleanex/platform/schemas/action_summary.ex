defmodule Gleanex.Platform.ActionSummary do
  @moduledoc """
  Provides struct and type for a ActionSummary
  """

  @type t :: %__MODULE__{
          auth_type: String.t() | nil,
          data_source: String.t() | nil,
          display_name: String.t(),
          is_setup_finished: boolean | nil,
          tool_id: String.t(),
          type: String.t() | nil,
          write_action_type: String.t() | nil
        }

  defstruct [
    :auth_type,
    :data_source,
    :display_name,
    :is_setup_finished,
    :tool_id,
    :type,
    :write_action_type
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      auth_type: :string,
      data_source: :string,
      display_name: :string,
      is_setup_finished: :boolean,
      tool_id: :string,
      type: :string,
      write_action_type: :string
    ]
  end
end
