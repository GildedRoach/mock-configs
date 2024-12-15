config_opts['root'] = 'terra-el{{ releasever }}-dev-{{ target_arch }}'
config_opts['package_manager'] = 'dnf'
config_opts['extra_chroot_dirs'] = [ '/run/lock', ]
config_opts['plugin_conf']['root_cache_enable'] = True
config_opts['plugin_conf']['yum_cache_enable'] = True
config_opts['plugin_conf']['ccache_enable'] = True
config_opts['plugin_conf']['ccache_opts']['compress'] = 'on'
config_opts['plugin_conf']['ccache_opts']['max_cache_size'] = '10G'
#config_opts['chroot_setup_cmd'] = 'install @{% if mirrored %}buildsys-{% endif %}build'
config_opts['chroot_setup_cmd'] = 'install bash bzip2 coreutils cpio diffutils redhat-release findutils gawk glibc-minimal-langpack grep gzip info patch redhat-rpm-config rpm-build sed tar unzip util-linux which xz epel-rpm-macros epel-release'
config_opts['dist'] = 'el{{ releasever }}'  # only useful for --resultdir variable subst
config_opts['bootstrap_image'] = 'ghcr.io/terrapkg/builder:el{{ releasever }}'


config_opts['dnf.conf'] = """
[main]
keepcache=1
debuglevel=2
reposdir=/dev/null
logfile=/var/log/yum.log
retries=20
obsoletes=1
gpgcheck=0
assumeyes=1
syslog_ident=mock
syslog_device=
metadata_expire=0
best=1
install_weak_deps=0
protected_packages=
skip_if_unavailable=False
module_platform_id=platform:el10
user_agent={{ user_agent }}

[baseos]
name=CentOS Stream $releasever - BaseOS
#baseurl=http://mirror.stream.centos.org/$releasever-stream/BaseOS/$basearch/os/
metalink=https://mirrors.centos.org/metalink?repo=centos-baseos-$releasever-stream&arch=$basearch&protocol=https,http
gpgkey=file:///usr/share/distribution-gpg-keys/centos/RPM-GPG-KEY-CentOS-Official-SHA256
gpgcheck=1
countme=1
enabled=1

[appstream]
name=CentOS Stream $releasever - AppStream
#baseurl=http://mirror.stream.centos.org/$releasever-stream/AppStream/$basearch/os/
metalink=https://mirrors.centos.org/metalink?repo=centos-appstream-$releasever-stream&arch=$basearch&protocol=https,http
gpgkey=file:///usr/share/distribution-gpg-keys/centos/RPM-GPG-KEY-CentOS-Official-SHA256
gpgcheck=1
countme=1
enabled=1

[crb]
name=CentOS Stream $releasever - CRB
#baseurl=http://mirror.stream.centos.org/$releasever-stream/CRB/$basearch/os/
metalink=https://mirrors.centos.org/metalink?repo=centos-crb-$releasever-stream&arch=$basearch&protocol=https,http
gpgkey=file:///usr/share/distribution-gpg-keys/centos/RPM-GPG-KEY-CentOS-Official-SHA256
gpgcheck=1
countme=1
enabled=1

[extras-common]
name=CentOS Stream $releasever - Extras packages
#baseurl=http://mirror.stream.centos.org/SIGs/$releasever-stream/extras/$basearch/extras-common/
metalink=https://mirrors.centos.org/metalink?repo=centos-extras-sig-extras-common-$releasever-stream&arch=$basearch&protocol=https,http
gpgkey=file:///usr/share/distribution-gpg-keys/centos/RPM-GPG-KEY-CentOS-SIG-Extras-SHA512
gpgcheck=1
enabled=1
skip_if_unavailable=False

[terra]
name=Terra EL $releasever
metalink=https://tetsudou.fyralabs.com/metalink?repo=terrael$releasever&arch=$basearch
type=rpm
skip_if_unavailable=True
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://repos.fyralabs.com/terrael$releasever/key.asc
enabled=1
enabled_metadata=1
metadata_expire=4h

[terra-extras]
name=Terra EL $releasever (Extras)
metalink=https://tetsudou.fyralabs.com/metalink?repo=terrael$releasever-extras&arch=$basearch
metadata_expire=6h
type=rpm
gpgcheck=1
gpgkey=https://repos.fyralabs.com/terrael$releasever-extras/key.asc
repo_gpgcheck=1
enabled=0
enabled_metadata=1
priority=150

[epel]
name=Extra Packages for Enterprise Linux $releasever - $basearch
# It is much more secure to use the metalink, but if you wish to use a local mirror
# place its address here.
#baseurl=https://dl.fedoraproject.org/pub/epel/$releasever_major${releasever_minor:+.$releasever_minor}/Everything/$basearch/
metalink=https://mirrors.fedoraproject.org/metalink?repo=epel-$releasever_major${releasever_minor:+.$releasever_minor}&arch=$basearch
gpgkey=file:///usr/share/distribution-gpg-keys/epel/RPM-GPG-KEY-EPEL-$releasever_major
gpgcheck=1
countme=1
"""
