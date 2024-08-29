# Landetech Backend Challenge

This is a backend project built with Ruby on Rails for Landetech's technical challenge. The project is an API-only application that allows recruiters to manage jobs and submissions from candidates.

## Table of Contents

- [Requirements](#requirements)
- [Setup](#setup)
- [Usage](#usage)
- [API Endpoints](#api-endpoints)
- [Testing](#testing)
- [Contributing](#contributing)
- [License](#license)

## Requirements

- Ruby 2.7.2
- Rails 6.0.0
- PostgreSQL
- Redis (for background jobs)
- Elastic Search

## Setup

### 1. Clone the repository

```bash
git clone https://github.com/yourusername/landetech-backend-challenge.git
cd landetech-backend-challenge
```

### 2. Install dependencies

```bash
bundle install
```

### 3. Set up the database

```bash
rails db:create
rails db:migrate
```

### 4. Seed the database (optional)

```bash
rails db:seed
```

### 5. Start the server

```bash
rails server
```

### 6. Run Redis (required for Sidekiq)

```bash
redis-server
```

## Usage

This project provides an API for recruiters to manage job postings and for candidates to submit their applications.

### Authentication

- Recruiters must log in to manage jobs. JWT tokens are used for authentication.

### Recruiters

- Recruiters can create, read, update, and delete job postings.
- Recruiters can log in and out.

### Public API

- Candidates can view available jobs and submit their applications.

## API Endpoints

### Authentication

- **Login:** `POST /api/v1/auth/login`
- **Logout:** `DELETE /api/v1/auth/logout`

### Recruiters (Authenticated)

- **Create Job:** `POST /api/v1/recruiter/jobs`
- **Update Job:** `PUT /api/v1/recruiter/jobs/:id`
- **Delete Job:** `DELETE /api/v1/recruiter/jobs/:id`

### Public (No Authentication Required)

- **List Jobs:** `GET /api/v1/public/jobs`
- **View Job:** `GET /api/v1/public/jobs/:id`
- **Create Submission:** `POST /api/v1/public/submissions`

## Testing

This project uses RSpec for testing.

To run the test suite:

```bash
rspec
```

## Obs: para testar o fluco todo com Elastic Search necessario seguir os passos a baixo:
- rodar o seguintes comandos:
```bash
  docker run \
    --name elasticsearch-rails-searchapp \
    --publish 9200:9200 \
    --env "discovery.type=single-node" \
    --env "cluster.name=elasticsearch-rails" \
    --env "cluster.routing.allocation.disk.threshold_enabled=false" \
    --rm \
    docker.elastic.co/elasticsearch/elasticsearch:7.6.0
  ``` 

  ```bash
  rails s
  ```

Make sure to have FactoryBot configured and that you’ve created the necessary factories for testing.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request for any features, bug fixes, or improvements.
