{% from "forticlient/map.jinja" import forticlient with context %}

expect:
  pkg.installed

{% if not salt['file.directory_exists']("/tmp/{{ forticlient.pkgfilename }}") %}
/tmp/{{ forticlient.pkgfilename }}:
  file.managed:
    - source: https://filestore.fortinet.com/forticlient/downloads/{{ forticlient.pkgfilename }}
    - skip_verify: true
    - retry:
      - until: True
      - attempts: 5
      - interval: 10
{% endif %}

{% if not salt['file.directory_exists']('/opt/forticlient/vpn') %}
forticlient_vpn:
  pkg.installed:
    - sources:
      - forticlient: /tmp/{{ forticlient.pkgfilename }}
    - retry:
      - until: True
      - attempts: 5
      - interval: 10
{% endif %}
