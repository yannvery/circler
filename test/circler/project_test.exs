defmodule Circler.ProjectTest do
  use ExUnit.Case
  alias Circler.{Project, Client}

  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup do
    ExVCR.Config.cassette_library_dir("test/fixture/vcr_cassettes/project")
    :ok
  end

  test "list_all" do
    use_cassette "example_list_all" do
      client = Client.new("4defadf434f2dd041fe0b363fd365e7ff545523d")

      {:ok, response} = Project.list_all(client)

      assert is_list(response) == true
      assert(List.first(response)["reponame"]) == "test-reporter"
    end
  end

  test "project" do
    use_cassette "example_project" do
      client = Client.new("4defadf434f2dd041fe0b363fd365e7ff545523d")
      project = Project.new("github", "codeclimate", "test-reporter")

      {:ok, response} = Project.project(client, project)

      assert is_list(response) == true
      assert Map.has_key?(List.first(response), "all_commit_details") == true
    end
  end

end

