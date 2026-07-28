defmodule Gleanex.Indexing.LifeCycleEvent do
  @moduledoc """
  Provides struct and type for a LifeCycleEvent
  """

  @type t :: %__MODULE__{event: String.t() | nil, timestamp: String.t() | nil}

  defstruct [:event, :timestamp]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [event: {:enum, ["UPLOADED", "INDEXED", "DELETION_REQUESTED", "DELETED"]}, timestamp: :string]
  end
end
