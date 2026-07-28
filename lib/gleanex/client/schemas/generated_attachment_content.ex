defmodule Gleanex.Client.GeneratedAttachmentContent do
  @moduledoc """
  Provides struct and type for a GeneratedAttachmentContent
  """

  @type t :: %__MODULE__{displayHeader: String.t() | nil, text: String.t() | nil}

  defstruct [:displayHeader, :text]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [displayHeader: :string, text: :string]
  end
end
