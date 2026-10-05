defmodule Gleanex.Platform.ChatFileSource do
  @moduledoc """
  Provides struct and type for a ChatFileSource
  """

  @type t :: %__MODULE__{
          datasource: String.t() | nil,
          file_id: String.t(),
          title: String.t() | nil,
          type: String.t(),
          url: String.t() | nil
        }

  defstruct [:datasource, :file_id, :title, :type, :url]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [datasource: :string, file_id: :string, title: :string, type: {:const, "FILE"}, url: :string]
  end
end
