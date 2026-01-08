############################
# Stage 1: Build dependencies
############################
FROM node:18-alpine AS builder

WORKDIR /app

# Copy dependency manifests first (cache-friendly)
COPY services/entries-service/package.json services/entries-service/package-lock.json* ./

# Install only production dependencies
RUN npm ci --omit=dev || npm install --production

# Copy application source
COPY services/entries-service/. .
COPY protos ./protos

############################
# Stage 2: Runtime (secure)
############################
FROM node:18-alpine

# Create non-root user and group
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

WORKDIR /app

# Copy runtime artifacts only
COPY --from=builder /app /app

# Fix ownership
RUN chown -R appuser:appgroup /app

# Drop root privileges
USER appuser

# Runtime configuration (unchanged)
ENV HOST=0.0.0.0
ENV PORT=50051

EXPOSE 50051

CMD ["node", "index.js"]
