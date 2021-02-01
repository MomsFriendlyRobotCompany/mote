FROM debian:buster

# ENV PYTHONIOENCODING=UTF-8
# ENV LC_ALL=en_US.UTF-8
# ENV LANGUAGE=en_US.UTF-8

RUN apt-get update && apt-get install -y openssh-server sudo python3
RUN mkdir /var/run/sshd

# user:password | chpasswd
RUN useradd -ms /bin/bash pi && echo "pi:raspberry" | chpasswd
RUN adduser pi sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
