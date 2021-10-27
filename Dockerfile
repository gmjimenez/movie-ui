# Start from the alpine image that is smaller but no fancy tools
FROM ubuntu

#ADD /var/lib/jenkins/workspace/movie-api
# Use /usr/src/app as our workdir. The following instructions will be executed in this location.
WORKDIR /var/lib/jenkins/workspace/movie-ui


# Copy the hello.sh file from this location to /usr/src/app/ creating /usr/src/app/hello.sh
COPY * .

# Alternatively, if we skipped chmod earlier, we can add execution permissions during the build.
RUN chmod +x deb.sh

# When running docker run the command will be ./hello.sh
CMD ./deb.sh

#ENTRYPOINT 
