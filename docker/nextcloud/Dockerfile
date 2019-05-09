FROM nextcloud:fpm-alpine

RUN addgroup -g 2906 -S appuser && \
    adduser -u 2906 -S appuser -G appuser
USER appuser