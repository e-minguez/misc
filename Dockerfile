FROM centos/7  

RUN curl -k -o /etc/yum.repos.d/copr_ndokos-pbench.repo https://copr.fedorainfracloud.org/coprs/ndokos/pbench/repo/epel-7/ndokos-pbench-epel-7.repo && \
    yum -y install gcc pbench-agent lksctp-tools-devel make openssh-server openssh-server-sysvinit iproute openssh-clients && \
    yum clean all

RUN curl -k -O https://vorboss.dl.sourceforge.net/project/uperf/uperf/uperf-1.0.5.tar.gz && \
    tar -zxvf uperf-1.0.5.tar.gz && \
    cd uperf-1.0.5 && \
    ./configure && \
    make && \
    make install && \
    cd /tmp  
  
RUN ssh-keygen -A && \
    rm -f /lib/systemd/system/systemd*udev* && \
    rm -f /lib/systemd/system/getty.target && \
    systemctl enable sshd && \
    echo "root:redhat" | chpasswd  

CMD ["/usr/sbin/init"]
