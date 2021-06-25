defmodule Wabanex.Users.Get do
  import Ecto.Query

  alias Ecto.UUID
  alias Wabanex.{Repo, User, Training}

  def call(id) do
    id
    |> UUID.cast()
    |> handle_response()
  end

  defp handle_response(:error) do
    {:error, "Invalid UUID"}
  end

  defp handle_response({:ok, uuid}) do
    case Repo.get(User, uuid) do
      nil -> {:error, "User not found"}
      user -> {:ok, load_training(user)}
    end
  end

  defp load_training(user) do
    today = Date.utc_today()

    # ^ usado para fixar o valor na variável
    query =
      from(training in Training,
        where: ^today >= training.start_date and ^today <= training.end_date
      )

    # Retornando só o primeiro treino da query
    Repo.preload(user, trainings: {first(query, :inserted_at), :exercises})
  end
end
