defmodule Gleanex.Platform.AgentContentTrigger do
  @moduledoc """
  Provides struct and type for a AgentContentTrigger
  """

  @type t :: %__MODULE__{
          datasource: String.t(),
          document_type: String.t() | nil,
          filters: [Gleanex.Platform.AgentContentTriggerFilter.t()] | nil,
          template_id: String.t(),
          time_offset_seconds: integer | nil
        }

  defstruct [:datasource, :document_type, :filters, :template_id, :time_offset_seconds]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      datasource: :string,
      document_type: :string,
      filters: [{Gleanex.Platform.AgentContentTriggerFilter, :t}],
      template_id: :string,
      time_offset_seconds: {:integer, "int32"}
    ]
  end
end
