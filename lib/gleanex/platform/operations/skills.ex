defmodule Gleanex.Platform.Skills do
  @moduledoc """
  Provides API endpoints related to skills
  """

  @default_client Gleanex.HTTP

  @doc """
  Create skill

  Create a skill from an uploaded SKILL.md, .zip, or .skill bundle. If the authenticated user already has a skill with the same name, the existing skill is superseded with a new version.

  ## Request Body

  **Content Types**: `multipart/form-data`
  """
  @spec create(body :: Gleanex.Platform.SkillCreateRequest.t(), opts :: keyword) ::
          {:ok, Gleanex.Platform.SkillCreateResponse.t()} | {:error, Gleanex.Error.t()}
  def create(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Platform.Skills, :create},
      url: "/skills",
      body: body,
      method: :post,
      request: [{"multipart/form-data", {Gleanex.Platform.SkillCreateRequest, :t}}],
      response: [
        {200, {Gleanex.Platform.SkillCreateResponse, :t}},
        {400, {Gleanex.Platform.ProblemDetail, :t}},
        {401, {Gleanex.Platform.ProblemDetail, :t}},
        {403, {Gleanex.Platform.ProblemDetail, :t}},
        {404, {Gleanex.Platform.ProblemDetail, :t}},
        {408, {Gleanex.Platform.ProblemDetail, :t}},
        {413, {Gleanex.Platform.ProblemDetail, :t}},
        {429, {Gleanex.Platform.ProblemDetail, :t}},
        {500, {Gleanex.Platform.ProblemDetail, :t}},
        {503, {Gleanex.Platform.ProblemDetail, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Create skill version

  Create a new immutable version for an existing caller-managed skill from an uploaded SKILL.md, .zip, or .skill bundle.

  ## Request Body

  **Content Types**: `multipart/form-data`
  """
  @spec create_version(
          skill_id :: String.t(),
          body :: Gleanex.Platform.SkillVersionCreateRequest.t(),
          opts :: keyword
        ) :: {:ok, Gleanex.Platform.SkillVersionCreateResponse.t()} | {:error, Gleanex.Error.t()}
  def create_version(skill_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [skill_id: skill_id, body: body],
      call: {Gleanex.Platform.Skills, :create_version},
      url: "/skills/#{skill_id}/versions",
      body: body,
      method: :post,
      request: [{"multipart/form-data", {Gleanex.Platform.SkillVersionCreateRequest, :t}}],
      response: [
        {200, {Gleanex.Platform.SkillVersionCreateResponse, :t}},
        {400, {Gleanex.Platform.ProblemDetail, :t}},
        {401, {Gleanex.Platform.ProblemDetail, :t}},
        {403, {Gleanex.Platform.ProblemDetail, :t}},
        {404, {Gleanex.Platform.ProblemDetail, :t}},
        {408, {Gleanex.Platform.ProblemDetail, :t}},
        {409, {Gleanex.Platform.ProblemDetail, :t}},
        {413, {Gleanex.Platform.ProblemDetail, :t}},
        {429, {Gleanex.Platform.ProblemDetail, :t}},
        {500, {Gleanex.Platform.ProblemDetail, :t}},
        {503, {Gleanex.Platform.ProblemDetail, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Delete skill

  Delete a skill the authenticated caller is allowed to manage. This operation permanently removes all versions of the skill.

  """
  @spec delete(skill_id :: String.t(), opts :: keyword) :: :ok | {:error, Gleanex.Error.t()}
  def delete(skill_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [skill_id: skill_id],
      call: {Gleanex.Platform.Skills, :delete},
      url: "/skills/#{skill_id}",
      method: :delete,
      response: [
        {204, :null},
        {400, {Gleanex.Platform.ProblemDetail, :t}},
        {401, {Gleanex.Platform.ProblemDetail, :t}},
        {403, {Gleanex.Platform.ProblemDetail, :t}},
        {404, {Gleanex.Platform.ProblemDetail, :t}},
        {408, {Gleanex.Platform.ProblemDetail, :t}},
        {429, {Gleanex.Platform.ProblemDetail, :t}},
        {500, {Gleanex.Platform.ProblemDetail, :t}},
        {503, {Gleanex.Platform.ProblemDetail, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Retrieve skill

  Retrieve metadata for a skill available to the authenticated user.

  """
  @spec get(skill_id :: String.t(), opts :: keyword) ::
          {:ok, Gleanex.Platform.SkillGetResponse.t()} | {:error, Gleanex.Error.t()}
  def get(skill_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [skill_id: skill_id],
      call: {Gleanex.Platform.Skills, :get},
      url: "/skills/#{skill_id}",
      method: :get,
      response: [
        {200, {Gleanex.Platform.SkillGetResponse, :t}},
        {400, {Gleanex.Platform.ProblemDetail, :t}},
        {401, {Gleanex.Platform.ProblemDetail, :t}},
        {403, {Gleanex.Platform.ProblemDetail, :t}},
        {404, {Gleanex.Platform.ProblemDetail, :t}},
        {408, {Gleanex.Platform.ProblemDetail, :t}},
        {429, {Gleanex.Platform.ProblemDetail, :t}},
        {500, {Gleanex.Platform.ProblemDetail, :t}},
        {503, {Gleanex.Platform.ProblemDetail, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Download skill content

  Download the latest installable bundle for a skill available to the authenticated user.

  """
  @spec get_content(skill_id :: String.t(), opts :: keyword) ::
          {:ok, binary} | {:error, Gleanex.Error.t()}
  def get_content(skill_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [skill_id: skill_id],
      call: {Gleanex.Platform.Skills, :get_content},
      url: "/skills/#{skill_id}/content",
      method: :get,
      response: [
        {200, {:string, "binary"}},
        {400, {Gleanex.Platform.ProblemDetail, :t}},
        {401, {Gleanex.Platform.ProblemDetail, :t}},
        {403, {Gleanex.Platform.ProblemDetail, :t}},
        {404, {Gleanex.Platform.ProblemDetail, :t}},
        {408, {Gleanex.Platform.ProblemDetail, :t}},
        {429, {Gleanex.Platform.ProblemDetail, :t}},
        {500, {Gleanex.Platform.ProblemDetail, :t}},
        {503, {Gleanex.Platform.ProblemDetail, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Retrieve skill version

  Retrieve metadata for a skill version available to the authenticated user.

  """
  @spec get_version(skill_id :: String.t(), version :: integer, opts :: keyword) ::
          {:ok, Gleanex.Platform.SkillVersionGetResponse.t()} | {:error, Gleanex.Error.t()}
  def get_version(skill_id, version, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [skill_id: skill_id, version: version],
      call: {Gleanex.Platform.Skills, :get_version},
      url: "/skills/#{skill_id}/versions/#{version}",
      method: :get,
      response: [
        {200, {Gleanex.Platform.SkillVersionGetResponse, :t}},
        {400, {Gleanex.Platform.ProblemDetail, :t}},
        {401, {Gleanex.Platform.ProblemDetail, :t}},
        {403, {Gleanex.Platform.ProblemDetail, :t}},
        {404, {Gleanex.Platform.ProblemDetail, :t}},
        {408, {Gleanex.Platform.ProblemDetail, :t}},
        {429, {Gleanex.Platform.ProblemDetail, :t}},
        {500, {Gleanex.Platform.ProblemDetail, :t}},
        {503, {Gleanex.Platform.ProblemDetail, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Download skill version content

  Download the installable bundle for a skill version available to the authenticated user.

  """
  @spec get_version_content(skill_id :: String.t(), version :: integer, opts :: keyword) ::
          {:ok, binary} | {:error, Gleanex.Error.t()}
  def get_version_content(skill_id, version, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [skill_id: skill_id, version: version],
      call: {Gleanex.Platform.Skills, :get_version_content},
      url: "/skills/#{skill_id}/versions/#{version}/content",
      method: :get,
      response: [
        {200, {:string, "binary"}},
        {400, {Gleanex.Platform.ProblemDetail, :t}},
        {401, {Gleanex.Platform.ProblemDetail, :t}},
        {403, {Gleanex.Platform.ProblemDetail, :t}},
        {404, {Gleanex.Platform.ProblemDetail, :t}},
        {408, {Gleanex.Platform.ProblemDetail, :t}},
        {429, {Gleanex.Platform.ProblemDetail, :t}},
        {500, {Gleanex.Platform.ProblemDetail, :t}},
        {503, {Gleanex.Platform.ProblemDetail, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Import skills from GitHub

  Import one or more skills selected from a GitHub source preview. Each source URL is fetched and persisted as an independent skill with source provenance. This operation does not create a durable source resource. The import is atomic: if any source cannot be fetched, validated, or persisted, no skills are created.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec import(body :: Gleanex.Platform.SkillImportRequest.t(), opts :: keyword) ::
          {:ok, Gleanex.Platform.SkillImportResponse.t()} | {:error, Gleanex.Error.t()}
  def import body, opts \\ [] do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Platform.Skills, :import},
      url: "/skills/import",
      body: body,
      method: :post,
      request: [{"application/json", {Gleanex.Platform.SkillImportRequest, :t}}],
      response: [
        {200, {Gleanex.Platform.SkillImportResponse, :t}},
        {400, {Gleanex.Platform.ProblemDetail, :t}},
        {401, {Gleanex.Platform.ProblemDetail, :t}},
        {403, {Gleanex.Platform.ProblemDetail, :t}},
        {408, {Gleanex.Platform.ProblemDetail, :t}},
        {409, {Gleanex.Platform.ProblemDetail, :t}},
        {413, {Gleanex.Platform.ProblemDetail, :t}},
        {429, {Gleanex.Platform.ProblemDetail, :t}},
        {500, {Gleanex.Platform.ProblemDetail, :t}},
        {503, {Gleanex.Platform.ProblemDetail, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List skills

  List skills available to the authenticated user.

  ## Options

    * `page_size`: Maximum number of skills to return.
    * `cursor`: Opaque pagination cursor from a previous response.

  """
  @spec list(opts :: keyword) ::
          {:ok, Gleanex.Platform.SkillsListResponse.t()} | {:error, Gleanex.Error.t()}
  def list(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:cursor, :page_size])

    client.request(%{
      args: [],
      call: {Gleanex.Platform.Skills, :list},
      url: "/skills",
      method: :get,
      query: query,
      response: [
        {200, {Gleanex.Platform.SkillsListResponse, :t}},
        {400, {Gleanex.Platform.ProblemDetail, :t}},
        {401, {Gleanex.Platform.ProblemDetail, :t}},
        {403, {Gleanex.Platform.ProblemDetail, :t}},
        {404, {Gleanex.Platform.ProblemDetail, :t}},
        {408, {Gleanex.Platform.ProblemDetail, :t}},
        {429, {Gleanex.Platform.ProblemDetail, :t}},
        {500, {Gleanex.Platform.ProblemDetail, :t}},
        {503, {Gleanex.Platform.ProblemDetail, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List skill versions

  List versions for a skill available to the authenticated user.

  ## Options

    * `page_size`: Maximum number of versions to return.
    * `cursor`: Opaque pagination cursor from a previous response.

  """
  @spec list_versions(skill_id :: String.t(), opts :: keyword) ::
          {:ok, Gleanex.Platform.SkillVersionsListResponse.t()} | {:error, Gleanex.Error.t()}
  def list_versions(skill_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:cursor, :page_size])

    client.request(%{
      args: [skill_id: skill_id],
      call: {Gleanex.Platform.Skills, :list_versions},
      url: "/skills/#{skill_id}/versions",
      method: :get,
      query: query,
      response: [
        {200, {Gleanex.Platform.SkillVersionsListResponse, :t}},
        {400, {Gleanex.Platform.ProblemDetail, :t}},
        {401, {Gleanex.Platform.ProblemDetail, :t}},
        {403, {Gleanex.Platform.ProblemDetail, :t}},
        {404, {Gleanex.Platform.ProblemDetail, :t}},
        {408, {Gleanex.Platform.ProblemDetail, :t}},
        {429, {Gleanex.Platform.ProblemDetail, :t}},
        {500, {Gleanex.Platform.ProblemDetail, :t}},
        {503, {Gleanex.Platform.ProblemDetail, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Preview a GitHub skill source

  Inspect a GitHub URL without persisting a source or any discovered skills. Set stream to true to receive repository scan progress as server-sent events; otherwise the response contains the completed preview.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec preview_source(body :: Gleanex.Platform.SkillSourcePreviewRequest.t(), opts :: keyword) ::
          {:ok, Gleanex.Platform.SkillSourcePreviewResponse.t() | String.t()}
          | {:error, Gleanex.Error.t()}
  def preview_source(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Platform.Skills, :preview_source},
      url: "/skills/sources/preview",
      body: body,
      method: :post,
      request: [{"application/json", {Gleanex.Platform.SkillSourcePreviewRequest, :t}}],
      response: [
        {200, {:union, [:string, {Gleanex.Platform.SkillSourcePreviewResponse, :t}]}},
        {400, {Gleanex.Platform.ProblemDetail, :t}},
        {401, {Gleanex.Platform.ProblemDetail, :t}},
        {403, {Gleanex.Platform.ProblemDetail, :t}},
        {408, {Gleanex.Platform.ProblemDetail, :t}},
        {413, {Gleanex.Platform.ProblemDetail, :t}},
        {429, {Gleanex.Platform.ProblemDetail, :t}},
        {500, {Gleanex.Platform.ProblemDetail, :t}},
        {503, {Gleanex.Platform.ProblemDetail, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Sync a GitHub-imported skill

  Refresh one GitHub-imported skill from its stored source URL. If the skill content has changed, this operation creates a new skill version. If the skill is no longer present upstream, the stored skill is left unchanged and must be deleted explicitly.

  """
  @spec sync(skill_id :: String.t(), opts :: keyword) ::
          {:ok, Gleanex.Platform.SkillSyncResponse.t()} | {:error, Gleanex.Error.t()}
  def sync(skill_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [skill_id: skill_id],
      call: {Gleanex.Platform.Skills, :sync},
      url: "/skills/#{skill_id}/sync",
      method: :post,
      response: [
        {200, {Gleanex.Platform.SkillSyncResponse, :t}},
        {400, {Gleanex.Platform.ProblemDetail, :t}},
        {401, {Gleanex.Platform.ProblemDetail, :t}},
        {403, {Gleanex.Platform.ProblemDetail, :t}},
        {404, {Gleanex.Platform.ProblemDetail, :t}},
        {408, {Gleanex.Platform.ProblemDetail, :t}},
        {409, {Gleanex.Platform.ProblemDetail, :t}},
        {413, {Gleanex.Platform.ProblemDetail, :t}},
        {429, {Gleanex.Platform.ProblemDetail, :t}},
        {500, {Gleanex.Platform.ProblemDetail, :t}},
        {503, {Gleanex.Platform.ProblemDetail, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Update skill

  Update mutable metadata for a skill. V1 supports enabling or disabling a skill without changing its content.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec update(
          skill_id :: String.t(),
          body :: Gleanex.Platform.SkillUpdateRequest.t(),
          opts :: keyword
        ) :: {:ok, Gleanex.Platform.SkillUpdateResponse.t()} | {:error, Gleanex.Error.t()}
  def update(skill_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [skill_id: skill_id, body: body],
      call: {Gleanex.Platform.Skills, :update},
      url: "/skills/#{skill_id}",
      body: body,
      method: :patch,
      request: [{"application/json", {Gleanex.Platform.SkillUpdateRequest, :t}}],
      response: [
        {200, {Gleanex.Platform.SkillUpdateResponse, :t}},
        {400, {Gleanex.Platform.ProblemDetail, :t}},
        {401, {Gleanex.Platform.ProblemDetail, :t}},
        {403, {Gleanex.Platform.ProblemDetail, :t}},
        {404, {Gleanex.Platform.ProblemDetail, :t}},
        {408, {Gleanex.Platform.ProblemDetail, :t}},
        {409, {Gleanex.Platform.ProblemDetail, :t}},
        {413, {Gleanex.Platform.ProblemDetail, :t}},
        {429, {Gleanex.Platform.ProblemDetail, :t}},
        {500, {Gleanex.Platform.ProblemDetail, :t}},
        {503, {Gleanex.Platform.ProblemDetail, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Validate skill bundle

  Validate a skill bundle without persisting it. Accepts a SKILL.md, .zip, or .skill upload and returns parsed metadata plus the normalized file layout.

  ## Request Body

  **Content Types**: `multipart/form-data`
  """
  @spec validate(body :: Gleanex.Platform.SkillValidationRequest.t(), opts :: keyword) ::
          {:ok, Gleanex.Platform.SkillValidationResponse.t()} | {:error, Gleanex.Error.t()}
  def validate(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Gleanex.Platform.Skills, :validate},
      url: "/skills/validation",
      body: body,
      method: :post,
      request: [{"multipart/form-data", {Gleanex.Platform.SkillValidationRequest, :t}}],
      response: [
        {200, {Gleanex.Platform.SkillValidationResponse, :t}},
        {400, {Gleanex.Platform.ProblemDetail, :t}},
        {401, {Gleanex.Platform.ProblemDetail, :t}},
        {403, {Gleanex.Platform.ProblemDetail, :t}},
        {404, {Gleanex.Platform.ProblemDetail, :t}},
        {408, {Gleanex.Platform.ProblemDetail, :t}},
        {413, {Gleanex.Platform.ProblemDetail, :t}},
        {429, {Gleanex.Platform.ProblemDetail, :t}},
        {500, {Gleanex.Platform.ProblemDetail, :t}},
        {503, {Gleanex.Platform.ProblemDetail, :t}}
      ],
      opts: opts
    })
  end
end
