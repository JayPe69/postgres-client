# PostgreSQL Client Docker Image

**ALWAYS follow these instructions first and fallback to additional search and context gathering only if the information in the instructions is incomplete or found to be in error.**

This repository builds a lightweight Alpine Linux-based Docker image containing PostgreSQL client tools and curl. The image is automatically built and published to Docker Hub at [jnovent/postgres-client](https://hub.docker.com/r/jnovent/postgres-client).

## Working Effectively

### Repository Structure
- **Dockerfile**: Simple Alpine-based image configuration
- **README.md**: Basic documentation
- **.dockerignore**: Standard Docker ignore patterns
- **.github/workflows/build-and-push.yml**: CI/CD pipeline for automated builds

### Build Process
- **Local Docker Build**: `docker build -t postgres-client .`
  - **EXPECTED FAILURE**: Build fails in sandboxed environments due to network/firewall limitations accessing Alpine package repositories
  - **Error**: "WARNING: fetching https://dl-cdn.alpinelinux.org/alpine/v3.22/main: Permission denied"
  - **Duration**: Fails after ~2 minutes with exit code 4
  - **NEVER CANCEL**: Always wait for builds to complete or fail naturally
- **Alternative**: Pull and test existing image: `docker pull jnovent/postgres-client:latest`

### Testing and Validation
**ALWAYS validate functionality using the official Docker Hub image:**

1. **Pull Official Image**: `docker pull jnovent/postgres-client:latest` (takes 30-60 seconds)
2. **Test PostgreSQL Client**: `docker run --rm jnovent/postgres-client:latest psql --version`
   - Expected output: `psql (PostgreSQL) 17.2`
3. **Test curl**: `docker run --rm jnovent/postgres-client:latest curl --version`
   - Expected output: curl version with SSL and HTTP2 support
4. **List Available Tools**: `docker run --rm jnovent/postgres-client:latest sh -c "ls /usr/bin/pg*"`
   - Available tools: pg_amcheck, pg_basebackup, pg_dump, pg_dumpall, pg_isready, pg_receivewal, pg_recvlogical, pg_restore, pg_verifybackup, pgbench

### Manual Validation Scenarios
**ALWAYS perform these validation steps after making changes:**

1. **Interactive Shell Access**:
   ```bash
   docker run -it jnovent/postgres-client:latest /bin/sh
   ```

2. **PostgreSQL Connection Testing**:
   ```bash
   docker run --rm jnovent/postgres-client:latest pg_isready --help
   ```

3. **Database Operations Test** (requires external PostgreSQL):
   ```bash
   # Test connection capability
   docker run --rm jnovent/postgres-client:latest pg_isready -h hostname -p 5432 -U username -d database
   ```

## CI/CD Pipeline

### Automated Builds
- **Schedule**: Every Monday at 8:00 AM UTC
- **Trigger**: GitHub Actions workflow in `.github/workflows/build-and-push.yml`
- **Platforms**: linux/amd64, linux/arm64
- **Registry**: Docker Hub (jnovent/postgres-client)
- **Tags**: 
  - `latest` (always current)
  - `YYYYMMDD` (date-based versioning)

### Manual Workflow Trigger
- Use GitHub Actions "workflow_dispatch" to trigger builds manually
- **NEVER CANCEL**: Multi-platform builds can take 10-15 minutes
- **Build Timeout**: Set timeout to 30+ minutes for CI builds

### Required Secrets
- `DOCKER_USERNAME`: Docker Hub username
- `DOCKER_PASSWORD`: Docker Hub password/token

## Common Tasks

### Updating the Image
1. Modify `Dockerfile` as needed
2. **DO NOT** attempt local builds in sandboxed environments
3. Commit changes to trigger CI build:
   ```bash
   git add Dockerfile
   git commit -m "Update PostgreSQL client image"
   git push
   ```
4. Monitor GitHub Actions for build status
5. **Validate**: Pull and test updated image after CI completes

### Testing Changes
- **Local Testing**: Not possible in sandboxed environments due to network restrictions
- **CI Testing**: Rely on GitHub Actions builds
- **Validation**: Always test pulled images from Docker Hub

### Dockerfile Modifications
- Keep image minimal and Alpine-based
- Use `apk --no-cache` for package installations
- Combine RUN commands to minimize layers
- Always include both postgresql-client and curl packages

## Troubleshooting

### Build Failures
- **Network Issues**: Expected in sandboxed environments
- **Package Updates**: Alpine package index may change
- **Solution**: Use CI/CD pipeline for reliable builds

### Image Size Optimization
- Current image size: ~12MB compressed
- Use multi-stage builds if adding development tools
- Remove package caches with `--no-cache` flag

## Validation Checklist
Before committing changes, ALWAYS verify:
- [ ] Dockerfile syntax is correct
- [ ] `.dockerignore` excludes unnecessary files  
- [ ] GitHub Actions workflow validates
- [ ] Official image can be pulled and tested
- [ ] PostgreSQL client tools function correctly
- [ ] curl functionality works as expected
- [ ] Interactive shell access is available

## File Locations Reference

### Repository Root
```
.
├── .dockerignore          # Docker build exclusions
├── .git/                  # Git repository data
├── .github/
│   └── workflows/
│       └── build-and-push.yml  # CI/CD pipeline
├── Dockerfile             # Alpine + PostgreSQL client + curl
└── README.md              # Basic documentation
```

### Key Commands Quick Reference
```bash
# Pull official image
docker pull jnovent/postgres-client:latest

# Test functionality
docker run --rm jnovent/postgres-client:latest psql --version
docker run --rm jnovent/postgres-client:latest curl --version

# Interactive access
docker run -it jnovent/postgres-client:latest /bin/sh

# List PostgreSQL tools
docker run --rm jnovent/postgres-client:latest sh -c "ls /usr/bin/pg*"
```