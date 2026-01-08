############################
# Stage 1: Build dependencies
############################
FROM node:18-alpine AS builder

WORKDIR /app

# Copy dependency manifests first (better layer caching)
COPY services/moods-api/package.json services/moods-api/package-lock.json* ./

# Install only production dependencies
RUN npm ci --omit=dev || npm install --production

# Copy application source
COPY services/moods-api/. .
COPY protos ./protos

############################
# Stage 2: Runtime (secure)
############################
FROM node:18-alpine

# Create non-root user and group
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

WORKDIR /app

# Copy runtime artifacts from builder
COPY --from=builder /app /app

# Set correct ownership
RUN chown -R appuser:appgroup /app

# Drop root privileges
USER appuser

# Runtime configuration (unchanged)
ENV PORT=5002

EXPOSE 5002

CMD ["node", "index.js"]
