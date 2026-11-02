defmodule Gleanex.Platform.ListUsersResponse do
  @moduledoc """
  Provides struct and type for a ListUsersResponse
  """

  @type t :: %__MODULE__{
          has_more: boolean,
          next_cursor: String.t() | nil,
          request_id: String.t(),
          results: [Gleanex.Platform.User.t()]
        }

  defstruct [:has_more, :next_cursor, :request_id, :results]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      has_more: :boolean,
      next_cursor: {:union, [:string, :null]},
      request_id: :string,
      results: [{Gleanex.Platform.User, :t}]
    ]
  end
end
