defmodule WabanexWeb.Schema.Types.Training do
  use Absinthe.Schema.Notation

  import_types(WabanexWeb.Schema.Types.Exercise)

  @desc "Logic etraining repesentation"
  object :training do
    field(:id, non_null(:uuid4))
    field(:start_date, non_null(:string))
    field(:end_date, non_null(:string))
    field(:exercises, list_of(:exercise))
  end

  input_object :create_training_input do
    field(:user_id, non_null(:uuid4), description: "User id")
    field(:start_date, non_null(:string), description: "Start date training")
    field(:end_date, non_null(:string), description: "End date training")
    field(:exercises, list_of(:create_exercise_input), description: "Create list exercises")
  end
end
