#### Ruby on Rails Code Challenge

Project Requirements:

* Ruby version: 2.7.6
* Rails version: 5.2.6
* For the Engine Core, Turbo, Stimulus, Tailwind and Sweetalert2 were used.

#### Run Application

```bash
docker-compose build or docker compose build
```

```bash
docker compose run web rake db:create db:migrate #if necessary 
```

```bash
docker compose run web rake db:seed #if necessary
```

```bash
docker compose up #For start Application
```

For development, VSCODE's Devcontainer was used (https://code.visualstudio.com/docs/devcontainers/containers)

**CRUD Engine**

*An engine for company CRUD was developed.
A line was added to config/routes of the main application that mounts Engine::Core in /app*

The Engine was developed to show a little of my experience with Rails and Javascript.

It was necessary to add some extra routes in the Core engine because the main Application is api-only.

**It was necessary to use the http POST verb in the update_data.**
