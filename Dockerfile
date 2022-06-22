# Stage 1 - Build the web app
FROM ubuntu:22.04 AS builder

# Install Flutter from Github
RUN apt update && apt install -y curl git unzip xz-utils zip libglu1-mesa wget
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter
RUN /usr/local/flutter/bin/flutter doctor -v
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"
RUN flutter doctor -v

# Enable flutter web
RUN flutter channel master
RUN flutter upgrade
RUN flutter config --enable-web

# Build the web app from files in the current directory
RUN mkdir /app/
COPY . /app/
WORKDIR /app/
RUN flutter build web

# Stage 2 - Create a light web server image to serve built files
FROM nginx:1.20-alpine
COPY --from=builder /app/build/web /usr/share/nginx/html
