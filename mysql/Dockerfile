# Use the official MySQL base image
FROM mysql:8.0

# Set environment variables
ENV MYSQL_ROOT_PASSWORD=rootpassword
ENV MYSQL_DATABASE=testdb
ENV MYSQL_USER=testuser
ENV MYSQL_PASSWORD=testpassword

# Copy the initialization SQL scripts to the container
COPY data.sql /docker-entrypoint-initdb.d/

# Expose MySQL port
EXPOSE 3306
