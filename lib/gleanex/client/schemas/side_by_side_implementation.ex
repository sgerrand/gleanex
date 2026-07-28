defmodule Gleanex.Client.SideBySideImplementation do
  @moduledoc """
  Provides struct and type for a SideBySideImplementation
  """

  @type t :: %__MODULE__{
          implementationId: String.t() | nil,
          implementationName: String.t() | nil,
          response: String.t() | nil,
          responseMetadata: Gleanex.Client.SideBySideImplementationResponseMetadata.t() | nil,
          searchParams: map | nil
        }

  defstruct [:implementationId, :implementationName, :response, :responseMetadata, :searchParams]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      implementationId: :string,
      implementationName: :string,
      response: :string,
      responseMetadata: {Gleanex.Client.SideBySideImplementationResponseMetadata, :t},
      searchParams: :map
    ]
  end
end
