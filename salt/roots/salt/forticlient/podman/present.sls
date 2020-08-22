{#
Note:
Need to use "sudo -u -H bash -c 'command'" because minion doesn't interact with PAM. Thus, ulimit -Hn will be always 8192.
See https://github.com/saltstack/salt/issues/37768#issuecomment-261879041.
#}

{% if not salt['file.directory_exists']("/home/{{ pillar['username'] }}/{{ salt['pillar.get']('credential:certificate') }}") %}
/home/{{ pillar['username'] }}/forticlient/{{ pillar['credential']['certificate'] }}:
  file.managed:
    - source: salt://forticlient/secrets/{{ pillar['credential']['certificate'] }}
    - makedirs: true
{% endif %}

/home/{{ pillar['username'] }}/forticlient/start-vpn:
  file.managed:
    - source: salt://forticlient/scripts/start-vpn.sh.jinja
    - template: jinja
    - mode: 755
    - makedirs: true
    - force: true

/home/{{ pillar['username'] }}/forticlient/forticlient-vpn-answerbot:
  file.managed:
    - source: salt://forticlient/scripts/forticlient-vpn-answerbot.sh.jinja
    - template: jinja
    - mode: 755
    - makedirs: true
    - force: true

/home/{{ pillar['username'] }}/forticlient/Dockerfile:
  file.managed:
    - source: salt://forticlient/scripts/Dockerfile.jinja
    - template: jinja
    - makedirs: true
    - force: true

forticlient_vpn_podman:
  cmd.run:
    - name: sudo -u root -H bash -c "podman build -t {{ pillar['forticlient']['podman']['imagename'] }} . | tee podman-build.log"
    - cwd: /home/{{ pillar['username'] }}/forticlient
    - retry:
      - until: True
      - attempts: 5
      - interval: 10
    - require:
      - file: /home/{{ pillar['username'] }}/forticlient/{{ pillar['credential']['certificate'] }}
      - file: /home/{{ pillar['username'] }}/forticlient/start-vpn
      - file: /home/{{ pillar['username'] }}/forticlient/forticlient-vpn-answerbot
      - file: /home/{{ pillar['username'] }}/forticlient/Dockerfile
