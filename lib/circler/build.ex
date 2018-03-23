defmodule Circler.Build do
  @moduledoc """
  Functions for retrieving information about builds.
  """

  alias Circler.{Client, Project}

  @doc """
  Build summary for each of the last 30 recent builds, ordered by build_num.
  ## Example

    iex> client = Circler.Client.new("1234567890")
    Circler.Build.recent_builds(client)

  More info at: https://circleci.com/docs/api/v1-reference/#summary
  """
  @spec recent_builds(Client.t()) :: no_return()
  def recent_builds(client) do
    Circler.get("recent-builds", client)
  end

  @doc """
  Retrieve build informations of a project by its build number.
  ## Example

    iex> client = Circler.Client.new("1234567890")
    project = Circler.Project.new("github", "codeclimate", "test-reporter")
    Circler.Build.by_num(client, project, "560")

  More info at: https://circleci.com/docs/api/v1-reference/#summary
  """
  @spec by_num(Client.t(), Project.t(), String.t()) :: no_return()
  def by_num(client, project, build_num) do
    Circler.get(
      "project/" <>
        project.type <> "/" <> project.username <> "/" <> project.name <> "/" <> build_num,
      client
    )
  end

  @doc """
  List the artifacts produced by a given build.
  ## Example

    iex> client = Circler.Client.new("1234567890")
    project = Circler.Project.new("github", "codeclimate", "test-reporter")
    Circler.Build.artifacts(client, project, "560")

  More info at: https://circleci.com/docs/api/v1-reference/#summary
  """
  @spec artifacts(Client.t(), Project.t(), String.t()) :: no_return()
  def artifacts(client, project, build_num) do
    Circler.get(
      "project/" <>
        project.type <>
        "/" <> project.username <> "/" <> project.name <> "/" <> build_num <> "/artifacts",
      client
    )
  end
end
