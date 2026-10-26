defmodule Gleanex.Platform.DocumentsBatchResponse do
  @moduledoc """
  Provides struct and type for a DocumentsBatchResponse
  """

  @type t :: %__MODULE__{
          request_id: String.t(),
          results: [Gleanex.Platform.DocumentsBatchResult.t()],
          warnings: [Gleanex.Platform.DocumentsBatchWarning.t()]
        }

  defstruct [:request_id, :results, :warnings]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      request_id: :string,
      results: [{Gleanex.Platform.DocumentsBatchResult, :t}],
      warnings: [{Gleanex.Platform.DocumentsBatchWarning, :t}]
    ]
  end
end
