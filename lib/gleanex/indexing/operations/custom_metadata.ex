defmodule Gleanex.Indexing.CustomMetadata do
  @moduledoc """
  Provides API endpoints related to custom metadata
  """

  @default_client Gleanex.HTTP

  @doc """
  Remove metadata schema

  Deletes the schema definition for a metadata group. This does not delete existing metadata values on documents.
  """
  @spec custom_metadata_schema_group_name_delete(groupName :: String.t(), opts :: keyword) ::
          {:ok, Gleanex.Indexing.SuccessResponse.t()} | {:error, Gleanex.Error.t()}
  def custom_metadata_schema_group_name_delete(groupName, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [groupName: groupName],
      call: {Gleanex.Indexing.CustomMetadata, :custom_metadata_schema_group_name_delete},
      url: "/custom-metadata/schema/#{groupName}",
      method: :delete,
      response: [
        {200, {Gleanex.Indexing.SuccessResponse, :t}},
        {400, {Gleanex.Indexing.ErrorInfoResponse, :t}},
        {401, {Gleanex.Indexing.ErrorInfoResponse, :t}},
        {404, {Gleanex.Indexing.ErrorInfoResponse, :t}},
        {429, {Gleanex.Indexing.ErrorInfoResponse, :t}},
        {500, {Gleanex.Indexing.ErrorInfoResponse, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Retrieve metadata schema

  Retrieves the current schema definition for a metadata group.
  """
  @spec custom_metadata_schema_group_name_get(groupName :: String.t(), opts :: keyword) ::
          {:ok, Gleanex.Indexing.CustomMetadataSchema.t()} | {:error, Gleanex.Error.t()}
  def custom_metadata_schema_group_name_get(groupName, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [groupName: groupName],
      call: {Gleanex.Indexing.CustomMetadata, :custom_metadata_schema_group_name_get},
      url: "/custom-metadata/schema/#{groupName}",
      method: :get,
      response: [
        {200, {Gleanex.Indexing.CustomMetadataSchema, :t}},
        {401, {Gleanex.Indexing.ErrorInfoResponse, :t}},
        {404, {Gleanex.Indexing.ErrorInfoResponse, :t}},
        {429, {Gleanex.Indexing.ErrorInfoResponse, :t}},
        {500, {Gleanex.Indexing.ErrorInfoResponse, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Create or update metadata schema

  Defines or updates the schema for a metadata group. Schemas should be defined before indexing metadata.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec custom_metadata_schema_group_name_put(
          groupName :: String.t(),
          body :: Gleanex.Indexing.CustomMetadataSchema.t(),
          opts :: keyword
        ) :: {:ok, Gleanex.Indexing.SuccessResponse.t()} | {:error, Gleanex.Error.t()}
  def custom_metadata_schema_group_name_put(groupName, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [groupName: groupName, body: body],
      call: {Gleanex.Indexing.CustomMetadata, :custom_metadata_schema_group_name_put},
      url: "/custom-metadata/schema/#{groupName}",
      body: body,
      method: :put,
      request: [{"application/json", {Gleanex.Indexing.CustomMetadataSchema, :t}}],
      response: [
        {200, {Gleanex.Indexing.SuccessResponse, :t}},
        {400, {Gleanex.Indexing.ErrorInfoResponse, :t}},
        {401, {Gleanex.Indexing.ErrorInfoResponse, :t}},
        {409, {Gleanex.Indexing.ErrorInfoResponse, :t}},
        {429, {Gleanex.Indexing.ErrorInfoResponse, :t}},
        {500, {Gleanex.Indexing.ErrorInfoResponse, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Remove custom metadata

  Removes all custom metadata for the specified metadata group from a document.
  """
  @spec document_doc_id_custom_metadata_group_name_delete(
          docId :: String.t(),
          groupName :: String.t(),
          opts :: keyword
        ) :: {:ok, Gleanex.Indexing.SuccessResponse.t()} | {:error, Gleanex.Error.t()}
  def document_doc_id_custom_metadata_group_name_delete(docId, groupName, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [docId: docId, groupName: groupName],
      call: {Gleanex.Indexing.CustomMetadata, :document_doc_id_custom_metadata_group_name_delete},
      url: "/document/#{docId}/custom-metadata/#{groupName}",
      method: :delete,
      response: [
        {200, {Gleanex.Indexing.SuccessResponse, :t}},
        {400, {Gleanex.Indexing.ErrorInfoResponse, :t}},
        {401, {Gleanex.Indexing.ErrorInfoResponse, :t}},
        {404, {Gleanex.Indexing.ErrorInfoResponse, :t}},
        {429, {Gleanex.Indexing.ErrorInfoResponse, :t}},
        {500, {Gleanex.Indexing.ErrorInfoResponse, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Add or update custom metadata

  Associates custom metadata with a specific document. Custom metadata enables you to enrich documents with additional structured information that can be used for search, filtering, and faceting.

  ## Request Body

  **Content Types**: `application/json`
  """
  @spec document_doc_id_custom_metadata_group_name_put(
          docId :: String.t(),
          groupName :: String.t(),
          body :: Gleanex.Indexing.CustomMetadataPutRequest.t(),
          opts :: keyword
        ) :: {:ok, Gleanex.Indexing.SuccessResponse.t()} | {:error, Gleanex.Error.t()}
  def document_doc_id_custom_metadata_group_name_put(docId, groupName, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [docId: docId, groupName: groupName, body: body],
      call: {Gleanex.Indexing.CustomMetadata, :document_doc_id_custom_metadata_group_name_put},
      url: "/document/#{docId}/custom-metadata/#{groupName}",
      body: body,
      method: :put,
      request: [{"application/json", {Gleanex.Indexing.CustomMetadataPutRequest, :t}}],
      response: [
        {200, {Gleanex.Indexing.SuccessResponse, :t}},
        {400, {Gleanex.Indexing.ErrorInfoResponse, :t}},
        {401, {Gleanex.Indexing.ErrorInfoResponse, :t}},
        {404, {Gleanex.Indexing.ErrorInfoResponse, :t}},
        {429, {Gleanex.Indexing.ErrorInfoResponse, :t}},
        {500, {Gleanex.Indexing.ErrorInfoResponse, :t}}
      ],
      opts: opts
    })
  end
end
