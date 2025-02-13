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
name=AlmaLinux Kitten $releasever - BaseOS
mirrorlist=https://kitten.mirrors.almalinux.org/mirrorlist/$releasever-kitten/baseos
# baseurl=https://kitten.repo.almalinux.org/$releasever-kitten/BaseOS/$basearch/os/
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-AlmaLinux-10
skip_if_unavailable=False

[appstream]
name=AlmaLinux Kitten $releasever - AppStream
mirrorlist=https://kitten.mirrors.almalinux.org/mirrorlist/$releasever-kitten/appstream
# baseurl=https://kitten.repo.almalinux.org/$releasever-kitten/AppStream/$basearch/os/
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-AlmaLinux-10

[crb]
name=AlmaLinux Kitten $releasever - CRB
mirrorlist=https://kitten.mirrors.almalinux.org/mirrorlist/$releasever-kitten/crb
# baseurl=https://kitten.repo.almalinux.org/$releasever-kitten/CRB/$basearch/os/
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-AlmaLinux-10

[extras-common]
name=AlmaLinux Kitten $releasever - Extras
mirrorlist=https://kitten.mirrors.almalinux.org/mirrorlist/$releasever-kitten/extras-common
# baseurl=https://kitten.repo.almalinux.org/$releasever-kitten/extras-common/$basearch/os/
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-AlmaLinux-10

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
metalink=https://mirrors.fedoraproject.org/metalink?repo=epel-$releasever&arch=$basearch
gpgkey=file:///usr/share/distribution-gpg-keys/epel/RPM-GPG-KEY-EPEL-$releasever
gpgcheck=1
countme=1

"""