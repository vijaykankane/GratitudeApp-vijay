############################
# Stage 1: Build dependencies
############################
FROM node:18-alpine AS builder

WORKDIR /app

# Copy only dependency files first (better cache)
COPY services/stats-service/package.json services/stats-service/package-lock.json* ./

# Install only production dependencies
RUN npm ci --omit=dev || npm install --production

# Copy application source
COPY services/stats-service/. .
COPY protos ./protos

############################
# Stage 2: Runtime (secure)
############################
FROM node:18-alpine

# Create non-root user and group
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

WORKDIR /app

# Copy only required artifacts from builder
COPY --from=builder /app /app

# Set ownership to non-root user
RUN chown -R appuser:appgroup /app

# Switch to non-root user
USER appuser

# Environment variables (unchanged)
ENV HOST=0.0.0.0
ENV PORT=50053

EXPOSE 50053

CMD ["node", "index.js"]
