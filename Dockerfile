FROM jigsage/firefox

# Render listens on PORT env var, so expose that
ENV PORT=8080
EXPOSE 8080

# Dummy command - real use-case needed here
CMD ["tail", "-f", "/dev/null"]
