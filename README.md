# Distilled API

![Distilled API](https://drive.google.com/uc?export=download&id=11KQ66lmE0gpH34W7V1yFqvuzsIWYFgWF)

## Getting Started

To get started with the Distilled API, you will need to set up a development environment and install the required dependencies.
Prerequisites

Before you can start using the Distilled API, you will need to have the following tools installed on your system:

    - Ruby 2.7 or higher
    - Bundler
    - PostgreSQL

## Installation

To install the required dependencies for the Distilled API, follow these steps:

1. Clone the repository:

```
git clone https://github.com/[user]/distilled-api.git
```

2. Install the dependencies:

```
cd distilled-api
bundle install
```

3. Start the application

```
bundle exec rails s -p ${PORT:-3000} -e ${RACK_ENV:-production}
```

## API Documentation

Below is a list of the available API methods, with a brief description and example usage for each.

### createUser(email: String!, password: String!, name: String!): User

Creates a new user with the given email, password, and name. Returns the created user.

```
mutation {
  createUser(email: "john@example.com", password: "password123", name: "John Smith") {
    id
    email
    name
  }
}
```
### updateUser(id: ID!, email: String, password: String, name: String): User

Updates the user with the given ID. Returns the updated user.

```
mutation {
  updateUser(id: 1, email: "john@example.com", password: "password123", name: "John Smith") {
    id
    email
    name
  }
}
```

### deleteUser(id: ID!): Boolean

Deletes the user with the given ID. Returns true if the user was successfully deleted, false otherwise.

```
mutation {
  deleteUser(id: 1)
}
```

### createProject(name: String!, userId: ID!): Project

Creates a new project with the given name and user ID. Returns the created project.

```
mutation {
  createProject(name: "My Project", userId: 1) {
    id
    name
  }
}
```

### updateProject(id: ID!, name: String): Project

Updates the project with the given ID. Returns the updated project.

```
mutation {
  updateProject(id: 1, name: "My Updated Project") {
    id
    name
  }
}
```

### deleteProject(id: ID!): Boolean

Deletes the project with the given ID. Returns true if the project was successfully deleted, false otherwise.

```
mutation {
  deleteProject(id: 1)
}
```