# Task Manager API

A GraphQL API for personal task management
built with Ruby on Rails.

## Tech Stack
- Ruby 3.3.6
- Rails 8.1.3
- PostgreSQL
- GraphQL
- JWT Authentication
- RSpec
- Docker

## Quick Start with Docker
docker-compose up --build

## Manual Setup
1. bundle install
2. rails db:create db:migrate
3. rails server

## GraphQL Endpoint
POST http://localhost:3000/graphql

## Example Queries

### Sign Up
mutation {
  signUp(input: {
    email: "test@example.com"
    password: "password123"
  }) {
    token
    user { id email }
  }
}

### Create Task
mutation {
  createTask(input: {
    title: "My first task"
    priority: HIGH
    status: PENDING
  }) {
    id title status priority
  }
}

### Get Tasks with Filter
query {
  tasks(status: PENDING, priority: HIGH) {
    id title status priority dueDate
  }
}

## Testing
bundle exec rspec
