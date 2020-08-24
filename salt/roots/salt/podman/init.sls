{% if grains['os'] == 'Ubuntu' %}

podman_repo:
  pkgrepo.managed:
    - humanname: Podman Repository
    - name: deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_18.04/ /
    - file: /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list
    - gpgcheck: 1
    - key_url: https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_18.04/Release.key
podman:
  pkg.installed:
    - skip_verify: true

{% elif grains['os'] == 'CentOS' %}

https://github.com/containers/podman.git:
  git.detached:
    - rev: v2.0.2
    - target: /tmp/podman
    - user: {{ pillar['username'] }}

build_and_install_podman:
  cmd.run:
    - name: sudo make BUILDTAGS="selinux seccomp" package-install
    - cwd: /tmp/podman
    - runas: {{ pillar['username'] }}
    - require:
      - git: https://github.com/containers/podman.git

{% endif %}
