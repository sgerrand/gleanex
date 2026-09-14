defmodule Gleanex.Platform.TriggerCreateResponse do
  @moduledoc """
  Provides struct and type for a TriggerCreateResponse
  """

  @type t :: %__MODULE__{request_id: String.t(), trigger: Gleanex.Platform.TriggerWithSecret.t()}

  defstruct [:request_id, :trigger]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [request_id: :string, trigger: {Gleanex.Platform.TriggerWithSecret, :t}]
  end
end
