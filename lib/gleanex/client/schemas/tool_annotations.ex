defmodule Gleanex.Client.ToolAnnotations do
  @moduledoc """
  Provides struct and type for a ToolAnnotations
  """

  @type t :: %__MODULE__{
          destructiveHint: boolean | nil,
          idempotentHint: boolean | nil,
          openWorldHint: boolean | nil,
          readOnlyHint: boolean | nil,
          title: String.t() | nil
        }

  defstruct [:destructiveHint, :idempotentHint, :openWorldHint, :readOnlyHint, :title]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      destructiveHint: :boolean,
      idempotentHint: :boolean,
      openWorldHint: :boolean,
      readOnlyHint: :boolean,
      title: :string
    ]
  end
end
