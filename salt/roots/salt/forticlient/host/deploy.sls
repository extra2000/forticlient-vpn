{% if not salt['file.directory_exists']("/srv/{{ salt['pillar.get']('credential:certificate') }}") %}
/srv/{{ pillar['credential']['certificate'] }}:
  file.managed:
    - source: salt://forticlient/secrets/{{ pillar['credential']['certificate'] }}
    - mode: 400
{% endif %}

/usr/local/bin/start-vpn:
  file.managed:
    - source: salt://forticlient/scripts/start-vpn.sh.jinja
    - template: jinja
    - mode: 755
    - force: true

/usr/local/bin/forticlient-vpn-answerbot:
  file.managed:
    - source: salt://forticlient/scripts/forticlient-vpn-answerbot.sh.jinja
    - template: jinja
    - mode: 755
    - force: true

/lib/systemd/system/forticlient-vpn.service:
  file.managed:
    - source: salt://forticlient/scripts/forticlient-vpn.service.jinja
    - template: jinja
    - force: true

systemd-reload:
  cmd.run:
   - name: systemctl daemon-reload
   - onchanges:
     - file: /lib/systemd/system/forticlient-vpn.service

forticlient-vpn:
  service.running:
    - enable: True
