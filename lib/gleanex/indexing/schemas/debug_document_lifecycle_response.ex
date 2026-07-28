defmodule Gleanex.Indexing.DebugDocumentLifecycleResponse do
  @moduledoc """
  Provides struct and type for a DebugDocumentLifecycleResponse
  """

  @type t :: %__MODULE__{lifeCycleEvents: [Gleanex.Indexing.LifeCycleEvent.t()] | nil}

  defstruct [:lifeCycleEvents]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [lifeCycleEvents: [{Gleanex.Indexing.LifeCycleEvent, :t}]]
  end
end
