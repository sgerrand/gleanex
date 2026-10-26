defmodule Gleanex.Platform.DocumentsBatchRequest do
  @moduledoc """
  Provides struct and type for a DocumentsBatchRequest
  """

  @type t :: %__MODULE__{
          document_specs: [
            Gleanex.Platform.DocumentsBatchSpecById.t()
            | Gleanex.Platform.DocumentsBatchSpecByUrl.t()
          ],
          include: [String.t()] | nil
        }

  defstruct [:document_specs, :include]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      document_specs: [
        union: [
          {Gleanex.Platform.DocumentsBatchSpecById, :t},
          {Gleanex.Platform.DocumentsBatchSpecByUrl, :t}
        ]
      ],
      include: [const: "CONTENT"]
    ]
  end
end
