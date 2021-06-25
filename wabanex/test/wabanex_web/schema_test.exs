defmodule WabanexWeb.SchemaTest do
  use WabanexWeb.ConnCase, async: true

  alias Wabanex.User
  alias Wabanex.Users.Create

  describe "user queries" do
    test "when a valid id is given, returns the user", %{conn: conn} do
      params = %{name: "Josuel", email: "josuel@email.com", password: "1234567"}

      {:ok, %User{id: user_id}} = Create.call(params)

      query = """
      {
        getUser(id: "#{user_id}"){
          name,
          email
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      expected_response = %{
        "data" => %{
          "getUser" => %{
            "email" => "josuel@email.com",
            "name" => "Josuel"
          }
        }
      }

      assert response === expected_response
    end
  end

  describe "user mutations" do
    test "when all params are valid, creates the user", %{conn: conn} do
      mutation = """
        mutation {
          createUser(input: {name: "Josuel", email: "josuelteste@email.com", password: "teste123"}){
            id
            name
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: mutation})
        |> json_response(:ok)

      assert %{"data" => %{"createUser" => %{"id" => _id, "name" => "Josuel"}}} = response
    end
  end
end
