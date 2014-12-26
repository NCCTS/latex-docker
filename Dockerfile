# Docker version 1.4.1, build 5bc2ff8
FROM nccts/baseimage:0.0.10

# nccts/latex
# Version: 0.0.10
MAINTAINER "Michael Bradley" <michael.bradley@nccts.org>
# Ave, Regina Caelorum, ave, Domina Angelorum: salve, radix, salve, porta!

# Cache buster
ENV REFRESHED_AT [2014-12-25 Tue 03:53]

# Set environment variables
ENV HOME /root

# Add supporting files for the build
ADD . /docker-build

# Run main setup script, cleanup supporting files
RUN chmod -R 777 /docker-build
RUN /docker-build/setup.sh && rm -rf /docker-build

# Use phusion/baseimage's init system as the entrypoint:
# 'entry.sh' starts shell (or tmux) as the 'sailor' user
# (tmux: with a session named 'latex')
ENTRYPOINT ["/sbin/my_init", "--", "/usr/local/bin/entry.sh", "latex"]
CMD [""]

# example usage
# --------------------------------------------------
# docker run -it --rm nccts/latex
