FROM selenium/standalone-firefox:latest

# Install a lightweight Python HTTP server
USER root
RUN apt-get update && apt-get install -y python3

ENV PORT=8080
EXPOSE 8080

CMD ["python3", "-m", "http.server", "8080"]
