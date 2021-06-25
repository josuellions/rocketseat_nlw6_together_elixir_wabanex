defmodule Wabanex.UserTest do
  use Wabanex.DataCase, async: true

  alias Wabanex.User

  describe "changeset/1" do
    test "whe all params are valid, returns a valid changeset" do
      params = %{name: "Josuel", email: "josuel@email.com", password: "1234567"}

      response = User.changeset(params)

      assert %Ecto.Changeset{
               valid?: true,
               changes: %{email: "josuel@email.com", name: "Josuel", password: "1234567"},
               errors: []
             } = response
    end

    test "whe all params are valid, returns a invalid changeset" do
      params = %{name: "J", email: "josuel@email.com"}

      response = User.changeset(params)

      expected_response = %{
        name: ["should be at least 2 character(s)"],
        password: ["can't be blank"]
      }

      assert errors_on(response) == expected_response
    end
  end
end
