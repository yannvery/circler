defmodule Circler.Project do
  @moduledoc """
  Functions for retrieving information about projects.
  """
  alias Circler.Client

  defstruct type: nil, username: nil, name: nil

  @type t :: %__MODULE__{type: String.t, username: String.t, name: String.t}

  @doc """
  Create a Project struct with type, username and project name.
  ## Example

    iex> Circler.Project.new("github", "codeclimate", "test-reporter")

  More info at: https://circleci.com/docs/api/v1-reference/#summary
  """
  @spec new(String.t, String.t, String.t) :: t
  def new(type, username, name) do
    %__MODULE__{type: type, username: username, name: name}
  end


  @doc """
  List of all the projects you're following on CircleCI, with build information organized by branch.
  ## Example

    iex> client = Circler.Client.new("1234567890")
    Circler.Project.list_all(client)

  More info at: https://circleci.com/docs/api/v1-reference/#summary
  """
  @spec list_all(Client.t) :: {:atom, any()}
  def list_all(client) do
    Circler.get("projects", client)
  end

  @doc """
  Build summary for each of the last 30 builds for a single git repo.
  ## Example

    iex> client = Circler.Client.new("1234567890")
    project = Circler.Project.new("github", "codeclimate", "test-reporter")
    Circler.Project.project(client, project)

  More info at: https://circleci.com/docs/api/v1-reference/#summary
  """
  @spec project(Client.t, t) :: {:atom, any()}
  def project(client, project) do
    Circler.get("project/" <> project.type <> "/" <> project.username <> "/" <> project.name, client)
  end
end
