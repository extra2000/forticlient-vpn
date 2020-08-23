expect:
  pkg.installed

{% if not salt['file.directory_exists']('/tmp/FortiClientFullVPNInstaller_6.4.0.0851.rpm') %}
/tmp/FortiClientFullVPNInstaller_6.4.0.0851.rpm:
  file.managed:
    - source: https://filestore.fortinet.com/forticlient/downloads/FortiClientFullVPNInstaller_6.4.0.0851.rpm
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
      - forticlient: /tmp/FortiClientFullVPNInstaller_6.4.0.0851.rpm
    - retry:
      - until: True
      - attempts: 5
      - interval: 10
{% endif %}
