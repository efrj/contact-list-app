# Contacts Management Application

Esta é uma aplicação Ruby on Rails para gerenciar uma lista de contatos. O usuário pode se cadastrar, fazer login, adicionar, editar e excluir contatos, além de recuperar senhas e excluir sua conta. A aplicação utiliza o Geocoder para obter coordenadas geográficas a partir de endereços.

## Requisitos

- Ruby 3.0.2 ou superior
- Rails 7.0 ou superior
- PostgreSQL
- Docker
- Docker Compose

## Instalação

1. Clone o repositório:

    ```sh
    git clone https://github.com/efrj/contact-list-app.git
    ``` 

    ```sh
    cd contact-list-app
    ```

2. Configure as variáveis de ambiente:

    Copie o arquivo `.env.example` na raiz do projeto e salve como `.env`. 

    As variáveis já contém os valores default usados no projeto. Só altere se você tiver a necessidade de rodar a aplicação em outro ambiente.

3. Use o Docker Compose: 
    
    ```sh
    docker-compose up --build
    ```

4. Crie os bancos de dados, rode as migrations e o seed: 
    Entre no container da aplicação e crie o banco de dados.
    ```sh
    docker exec -it contato1.web sh
    ``` 
    ```sh
    rails db:create
    ``` 
    
    Ainda estando no container rode o comando das migrations e em seguida do seed.
    ```sh
    rails db:migrate
    ```

    ```sh
    rails db:seed
    ```

## Testes

Para executar os testes, entre no container da aplicação.
```sh
docker exec -it contato1.web sh
``` 

```sh
rails test
``` 
