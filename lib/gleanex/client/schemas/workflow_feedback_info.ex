defmodule Gleanex.Client.WorkflowFeedbackInfo do
  @moduledoc """
  Provides struct and type for a WorkflowFeedbackInfo
  """

  @type t :: %__MODULE__{source: String.t() | nil}

  defstruct [:source]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [source: {:enum, ["ZERO_STATE", "LIBRARY", "HOMEPAGE"]}]
  end
end
