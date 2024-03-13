# PostgreSQL + Liquibase + Docker playground

This project provides a Docker-based environment for working with PostgreSQL, Liquibase, and pgAdmin.

## Usage

To use this project, follow these steps:

1. Clone this repository to your local machine:

   ```bash
   git clone <repository_url>


2. Navigate to the project directory:

   ```bash
   cd LiquibaseDockerProject


3. Start the Docker containers using Docker Compose:

   ```bash
   docker-compose up --build


4. **Access pgAdmin:**  
   Access pgAdmin in your web browser at [http://localhost:5050](http://localhost:5050). Use the following credentials:

   - **Email:** ricardo072@gmail.com
   - **Password:** admin

5. **Connect to PostgreSQL Database:**  
   Connect to the PostgreSQL database using the following connection details:

   - **Host:** localhost
   - **Port:** 5432
   - **Username:** testuser
   - **Password:** docker
   - **Database:** testing

6. **Use Liquibase:**  
   Use Liquibase for managing database changes. The changelog file is located at `./liquibase/changelog/changelog.xml`.

## Services

### PostgreSQL

- **Image:** mypostgres:1.0
- **Environment Variables:**
  - POSTGRES_USER: testuser
  - POSTGRES_PASSWORD: docker
  - POSTGRES_DB: testing
- **Exposed Port:** 5432

### Liquibase

- **Image:** liquibase/liquibase:latest-alpine
- **Command:** `liquibase update --changeLogFile=/changelog/changelog.xml --url=jdbc:postgresql://postgres:5432/testing --username=testuser --password=docker`
- **Volumes:** `./liquibase/changelog:/liquibase/changelog/`

### pgAdmin

- **Image:** dpage/pgadmin4
- **Environment Variables:**
  - PGADMIN_DEFAULT_EMAIL: ricardo072@gmail.com
  - PGADMIN_DEFAULT_PASSWORD: admin
- **Exposed Port:** 5050

## Networking

The services are connected to a Docker network named `mynetwork`:

```yaml
networks:
  mynetwork:
    name: postgres
    driver: bridge

