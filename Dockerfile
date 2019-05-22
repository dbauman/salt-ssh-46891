FROM centos:centos7
RUN yum -y update; yum clean all
RUN yum -y install epel-release; yum clean all
RUN yum -y install python-pip; yum clean all
RUN yum -y install which zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel xz xz-devel libffi-devel findutils; yum clean all
RUN yum -y install openssh openssh-clients openssh-server; yum clean all

RUN pip install salt-ssh

RUN yum -y install python36 python36-pip; yum clean all
RUN pip3 install salt-ssh

RUN yum -y install sudo; yum clean all

RUN ["/usr/bin/ssh-keygen", "-q", "-t", "ecdsa", "-f", "/etc/ssh/ssh_host_ecdsa_key", "-C", "", "-N", ""]
RUN ["/usr/bin/ssh-keygen", "-q", "-t", "rsa", "-f", "/etc/ssh/ssh_host_rsa_key", "-C", "", "-N", ""]
RUN ["/usr/bin/ssh-keygen", "-q", "-t", "ed25519", "-f", "/etc/ssh/ssh_host_ed25519_key", "-C", "", "-N", ""]
RUN ["sed", "-i", "-es/^.*StrictHostKeyChecking.*$/StrictHostKeyChecking no/g", "/etc/ssh/ssh_config"]
RUN ["sed", "-i", "-es/^.*PubKeyAuthentication.*$/PubKeyAuthentication yes/g", "/etc/ssh/ssh_config"]

ADD sshu.sh /sshu.sh
RUN chmod 755 /sshu.sh

RUN /sbin/useradd -m -d /home/master -s /bin/bash master
RUN /bin/su -l -c /sshu.sh master
COPY master/ /home/master
RUN cp -p /home/master/.ssh/id_rsa /home/master/etc/salt/pki/master/ssh/salt-ssh.rsa
RUN chown -R master:master /home/master

RUN /sbin/useradd -m -d /home/minion -s /bin/bash minion
ADD sudoer.minion /etc/sudoers.d/minion
RUN chmod 440 /etc/sudoers.d/minion
RUN /bin/su -l -c /sshu.sh minion
RUN cp /home/master/.ssh/id_rsa.pub /home/minion/.ssh/authorized_keys
RUN chown minion:minion /home/minion/.ssh/authorized_keys

ADD startup.sh /startup.sh
RUN chmod a+x /startup.sh

ENTRYPOINT ["/startup.sh"]
CMD ["/bin/sudo", "-i", "-u", "master", "/bin/bash"]
