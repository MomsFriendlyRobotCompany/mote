FROM debian:buster

# ENV PYTHONIOENCODING=UTF-8
# ENV LC_ALL=en_US.UTF-8
# ENV LANGUAGE=en_US.UTF-8

RUN apt-get update && apt-get install -y openssh-server sudo python3
RUN mkdir /var/run/sshd
# RUN echo 'root:Passw0rd' | chpasswd
# RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
# RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# ENV NOTVISIBLE "in users profile"
# RUN echo "export VISIBLE=now" >> /etc/profile

# user:password | chpasswd
RUN useradd -ms /bin/bash pi && echo "pi:raspberry" | chpasswd
RUN adduser pi sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
