FROM mongo:latest

RUN mkdir -p /mnt/mongodb

RUN chmod 777 /mnt/mongodb

# # Configure MongoDB to use the mounted volume
# # RUN echo "[mongod]" > /etc/mongod.conf
RUN echo "storage:" >> /etc/mongod.conf
RUN echo "  dbPath: /mnt/mongodb" >> /etc/mongod.conf
RUN echo "net:" >> /etc/mongod.conf
RUN echo "  port: 27017" >> /etc/mongod.conf
RUN echo "  bindIp: 0.0.0.0" >> /etc/mongod.conf

RUN mkdir -p /docker-entrypoint-initdb.d

COPY seed_data.js /docker-entrypoint-initdb.d/seed_data.js

# Expose the MongoDB port
EXPOSE 27017

# Run MongoDB with the custom configuration
CMD ["mongod", "--config", "/etc/mongod.conf"]


