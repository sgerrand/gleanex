defmodule Gleanex.Platform.TriggerEventSearchResponse do
  @moduledoc """
  Provides struct and type for a TriggerEventSearchResponse
  """

  @type t :: %__MODULE__{
          has_more: boolean,
          request_id: String.t(),
          results: [Gleanex.Platform.TriggerEvent.t()]
        }

  defstruct [:has_more, :request_id, :results]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [has_more: :boolean, request_id: :string, results: [{Gleanex.Platform.TriggerEvent, :t}]]
  end
end
