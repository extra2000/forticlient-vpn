{% if grains['os'] == 'CentOS' %}

selinux_tools:
  pkg.installed:
    - pkgs:
      - checkpolicy
      - policycoreutils-python

{% endif %}
