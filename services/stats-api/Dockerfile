############################
# Stage 1: Build dependencies
############################
FROM node:18-alpine AS builder

WORKDIR /app

# Copy dependency files first (cache-friendly)
COPY services/stats-api/package.json services/stats-api/package-lock.json* ./

# Install only production dependencies
RUN npm ci --omit=dev || npm install --production

# Copy application source
COPY services/stats-api/. .
COPY protos ./protos

############################
# Stage 2: Runtime (secure)
############################
FROM node:18-alpine

# Create non-root user and group
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

WORKDIR /app

# Copy only required runtime artifacts
COPY --from=builder /app /app

# Set correct ownership
RUN chown -R appuser:appgroup /app

# Drop root privileges
USER appuser

# Runtime configuration (unchanged)
ENV PORT=5003

EXPOSE 5003

CMD ["node", "index.js"]
