defmodule Gleanex.Client.Code do
  @moduledoc """
  Provides struct and type for a Code
  """

  @type t :: %__MODULE__{
          fileName: String.t() | nil,
          fileUrl: String.t() | nil,
          isLastMatch: boolean | nil,
          lines: [Gleanex.Client.CodeLine.t()] | nil,
          repoName: String.t() | nil
        }

  defstruct [:fileName, :fileUrl, :isLastMatch, :lines, :repoName]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      fileName: :string,
      fileUrl: :string,
      isLastMatch: :boolean,
      lines: [{Gleanex.Client.CodeLine, :t}],
      repoName: :string
    ]
  end
end
