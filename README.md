# rocketseat_nlw6_together_elixir_wabanex

Semana NLW, criando aplicação backend com Elixir e GraphQL, cadastro de usuário e treinos, banco dados Postgres

## Aula - 01 | 20/06/2021 -> Domingo

### Instalação e configuração Erlang, Elixir e Phoenix

    	https://elixir-lang.org/install.html   
    	https://hexdocs.pm/phoenix/installation.html#phoenix
    	https://www.notion.so/Material-para-as-aulas-d12a95bc5c8c489e8299148fccab34e8

#### Criando Projeto com Elixir

```
$ mix phx.new wabanex --no-html --no-webpack
```

#### Instalar extensão VSCode

- ElixirLS: Elixir support and debugger

#### Criando estrutura do Banco dados Postgres

```
$ mix ecto.setup
```

    Criando modulo para calcular IMC
    -> Criar arquivo em /lib/wabanex/imc.ex

#### Carregando Elixir no terminal

```
$ iex -S mix
```

#### Lendo arquivo via terminal

```
iex(4)> File.read("students.csv")
```

#### Subindo server Elixir

```
$ mix phx.server
```

#### Criando Routes

    -> /lib/wabanex_web/views/routes.ex

```
get("/", IMCController, :index)
```

#### Criando Controller

    > /lib/wabanex_web/controller/imc_controller.ex

## Aula - 02 | 21/06/2021 -> Segunda-Feira

#### Criando Migration

```
$ mix ecto.gen.migration create_users_table
```

#### Executando a migration criando table no banco dados

```
$ mix ecto.migrate
```

#### Usando UUID

    -> configurar o arquivo
    	-> /wabanex/config/config.exs

```
        config :wabanex,
            ecto_repos: [Wabanex.Repo]

        config :wabanex, Wabanex.Repo,
          migration_primary_key: [type: :binary_id],
          migration_foreign_key: [type: :binary_id]
```

#### Resetando e apagando table do banco

```
$ mix ecto.reset
```

#### Criando Schema

    -> /lib/wabanex/user.ex

#### Documentação via terminal - digitar nome do modulo

```
$ h Ecto.Changeset.cast
```

## Aula - 03 | 22/06/2021 -> Terça-Feira

### GraphQL

#### Introdução

    - https://whimsical.com/wabanex-nlw-together-HX8K2N8J2cafinMFnRWQ6J
    - https://github.com/rocketseat-education/nlw-06-elixir/tree/3-day
    - https://github.com/absinthe-graphql/absinthe/wiki/Scalar-Recipes
    - https://github.com/absinthe-graphql/absinthe
    - https://github.com/absinthe-graphql/absinthe/wiki/Scalar-Recipes

    	-> Adicionar libs
    		-> /wabanex/mix.exs

```
            defp deps do [
                  ...,
                {:absinthe, "~> 1.5.0"},
                {:absinthe_plug, "~> 1.5"}
            ]
            end
```

    		-> no terminal

```
            $ mix deps.get
```

    	-> Adicionar routes.ex

```
  scope "/api" do
    pipe_through(:api)
    forward("/graphql", Absinthe.Plug, schema: WabanexWeb.Schema)
    forward("/graphiql", Absinthe.Plug.GraphiQL, schema: WabanexWeb.Schema)
  end
```

    	Criar arquivo
    	-> /wabanex/lib/wabanex_web/schema/types/user.ex

    	Criar arquivo
    	-> /wabanex/lib/wabanex_web/schema/types/root.ex

    	Criar arquivo
    	-> /wabanex/lib/wabanex_web/resolvers/user.ex

    	Criar arquivo
    	-> /wabanex/lib/wabanex_web/schema.ex

#### Consulta via terminal

```
iex(1)> Wabanex.Repo.all(Wabanex.User)
```

#### Consulta via navegador com GraphQL

```
http://localhost:4000/api/graphiql
```

#### Exemplo de consulta via navegador

```
{
  getUser(id: "5e7def56-71ca-406b-96fd-accaed9ccdc8"){
    email,
    name
  }
}
```

#### Exemplo de criar user pelo navegador

```
mutation {
  createUser(input: {name: "Maria", email: "maria@email.com", password: "teste123"}){
    id,
    name
  }
}
```

## Aula - 04 | 23/06/2021 -> Quarta-Feira

#### Criando Migration -  Tabela Treino

```
$ mix ecto.gen.migration create_trainings_table
```

#### Criando Migration -  Tabela Exercicios

```
$ mix ecto.gen.migration create_exercises_table
```

#### Executando a migration criando table no banco dados

```
$ mix ecto.migrate
```

#### Entidades e relacionamentos elixir com GraphQL

## Aula - 05 | 24/06/2021 -> Quinta-Feira

#### Carregando dados via terminal

```
iex -S mix
iex(8)> alias Wabanex.Repo
iex(8)> alias Wabanex.User
iex(8)> User |> Repo.all() |> Repo.preload([:trainings])
iex(8)> User |> Repo.all() |> Repo.preload([trainings: [:exercises]])
```

#### Consulta no GraphQL

```
{
  getUser(
    id: "9af1a965-3d78-4b5a-84bd-9fd732bf05bb"){
    id,
    name,
    email,
    trainings{
      id,
      startDate,
      endDate,
      exercises{
        name,
        repetitions
      }
    }
  }
}
```

#### Testes automatizados

    -> Criar aquivo
    	->/test/wabanex/imc_test.exs

    Executando teste no terminal no diretório da aplicação

```
$ mix test
```

#### Visualizando todas as Routes via terminal

```
$ mix phx.routes
```

#### Rodar todos os Teste e exibir o resultado via terminal

```
mix test --cover
```
