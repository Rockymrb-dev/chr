FROM selenium/standalone-firefox:latest

ENV PORT=8080
EXPOSE 8080

CMD ["sh", "-c", "while true; do echo 'Firefox container running'; sleep 3600; done"]
