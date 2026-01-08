############################
# Stage 1: Build dependencies
############################
FROM node:18-alpine AS builder

WORKDIR /app

# Copy dependency manifests first for better caching
COPY services/moods-service/package.json services/moods-service/package-lock.json* ./

# Install only production dependencies
RUN npm ci --omit=dev || npm install --production

# Copy application source
COPY services/moods-service/. .
COPY protos ./protos

############################
# Stage 2: Runtime (secure)
############################
FROM node:18-alpine

# Create non-root user and group
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

WORKDIR /app

# Copy only runtime artifacts
COPY --from=builder /app /app

# Fix ownership
RUN chown -R appuser:appgroup /app

# Drop root privileges
USER appuser

# Runtime configuration (unchanged)
ENV HOST=0.0.0.0
ENV PORT=50052

EXPOSE 50052

CMD ["node", "index.js"]
