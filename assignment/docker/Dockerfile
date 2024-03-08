FROM alpine:latest
COPY cron_job.sh /
RUN apk add --no-cache bash
RUN chmod +x /cron_job.sh
CMD ["/bin/bash", "./cron_job.sh"]
