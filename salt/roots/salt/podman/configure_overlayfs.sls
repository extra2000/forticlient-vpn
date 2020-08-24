{% if grains['os'] == 'CentOS' %}

fuse-overlayfs:
  pkg.installed:
    - pkgs:
      - fuse-overlayfs

storage_conf_use_overlayfs:
  file.replace:
    - name: /etc/containers/storage.conf
    - pattern: '^(#)(mount_program =.*)'
    - repl: '\g<2>'

{% endif %}
