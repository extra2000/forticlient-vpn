{%- if not salt['file.file_exists' ]('/usr/bin/podman') %}

https://github.com/containers/podman.git:
  git.detached:
    - rev: v2.0.2
    - target: /tmp/podman
    - user: {{ pillar['username'] }}
    - require:
      - pkg: common_packages

build_and_install_podman:
  cmd.run:
    - name: sudo make BUILDTAGS="selinux seccomp" package-install
    - cwd: /tmp/podman
    - runas: {{ pillar['username'] }}
    - require:
      - pkg: common_packages
      - git: https://github.com/containers/podman.git

{%- endif %}
