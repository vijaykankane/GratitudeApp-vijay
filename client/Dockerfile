# ---------- BUILD STAGE ----------
FROM node:24-alpine3.21 AS builder

WORKDIR /app

# Install deps first (better cache)
COPY package*.json ./
RUN npm ci

# Copy source and build
COPY . .
RUN npm run build

# ---------- RUNTIME STAGE ----------
FROM node:24-alpine3.21

# Security: non-root user
RUN addgroup -S app && adduser -S app -G app

WORKDIR /app

# Copy only required runtime artifacts
COPY --from=builder /app/package*.json ./
RUN npm ci --omit=dev && npm cache clean --force

# If frontend produces build folder (React/Vite)
COPY --from=builder /app/build ./build
# or if dist is used
# COPY --from=builder /app/dist ./dist

USER app

EXPOSE 3000
CMD ["npm", "start"]

