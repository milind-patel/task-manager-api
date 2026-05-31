# Task Manager API 🚀

[![CI](https://github.com/milind-patel/task-manager-api/actions/workflows/ci.yml/badge.svg)](https://github.com/milind-patel/task-manager-api/actions/workflows/ci.yml)

A robust GraphQL API for personal task management built with Ruby on Rails.

## 🛠 Tech Stack & Architecture
- **Framework:** Ruby 3.3.6, Rails 8.1.3
- **Database:** PostgreSQL 15
- **API Standard:** GraphQL (via `graphql-ruby`)
- **Authentication:** JWT via Devise & `devise-jwt` (Denylist strategy for secure token revocation)
- **Testing:** RSpec (with factory_bot & shoulda-matchers)
- **CI/CD:** GitHub Actions (Automated RSpec and Rubocop checks)

## 🏗 Design Decisions
- **GraphQL over REST:** Chosen for frontend flexibility, allowing the Next.js client to fetch exactly the data it needs in a single request without over-fetching.
- **JWT Denylist:** Uses a database-backed denylist to securely invalidate JWT tokens on logout, preventing token hijacking.

## 🚀 Quick Start (Docker)
The easiest way to run the application is via Docker Compose:
```bash
docker-compose up --build
```
The API will be available at `http://localhost:3000/graphql`.

## 💻 Local Setup (Without Docker)

### Prerequisites
- Ruby 3.3.6
- PostgreSQL

### Installation
1. Install dependencies:
   ```bash
   bundle install
   ```
2. Setup the database:
   ```bash
   bundle exec rails db:create db:migrate db:seed
   ```
3. Start the server:
   ```bash
   bundle exec rails server
   ```

## 🧪 Testing & Linting
Run the RSpec test suite:
```bash
bundle exec rspec
```

Run Rubocop for code formatting:
```bash
bundle exec rubocop
```

## 📡 Example GraphQL Queries

### Sign Up (Mutation)
```graphql
mutation {
  signUp(input: {
    email: "test@example.com"
    password: "password123"
  }) {
    token
    user { id email }
  }
}
```

### Create Task (Mutation)
*Requires Authorization header: `Bearer <token>`*
```graphql
mutation {
  createTask(input: {
    title: "Review PRs"
    priority: HIGH
    status: PENDING
  }) {
    id title status priority
  }
}
```

### Fetch Tasks (Query)
*Requires Authorization header: `Bearer <token>`*
```graphql
query {
  tasks(status: PENDING, priority: HIGH) {
    id 
    title 
    status 
    priority 
    dueDate
  }
}
```
