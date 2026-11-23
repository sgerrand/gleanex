defmodule Gleanex.Platform.DocumentsBatchWarning do
  @moduledoc """
  Provides struct and type for a DocumentsBatchWarning
  """

  @type t :: %__MODULE__{
          code: String.t(),
          context: Gleanex.Platform.DocumentsBatchWarningContext.t(),
          message: String.t()
        }

  defstruct [:code, :context, :message]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      code: :string,
      context: {Gleanex.Platform.DocumentsBatchWarningContext, :t},
      message: :string
    ]
  end
end
