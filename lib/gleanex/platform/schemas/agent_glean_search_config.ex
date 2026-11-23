defmodule Gleanex.Platform.AgentGleanSearchConfig do
  @moduledoc """
  Provides struct and type for a AgentGleanSearchConfig
  """

  @type t :: %__MODULE__{
          datasource_instances: [String.t()] | nil,
          knowledge_profile_id: String.t() | nil,
          urls: [String.t()] | nil
        }

  defstruct [:datasource_instances, :knowledge_profile_id, :urls]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [datasource_instances: [:string], knowledge_profile_id: :string, urls: [:string]]
  end
end
