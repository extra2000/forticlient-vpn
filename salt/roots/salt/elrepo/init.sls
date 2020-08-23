elrepo_key:
  cmd.run:
    - name: rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
    - retry:
      - until: True
      - attempts: 5
      - interval: 10

elrepo:
  pkg.installed:
    - sources:
      - elrepo-release: https://www.elrepo.org/elrepo-release-7.el7.elrepo.noarch.rpm
    - retry:
      - until: True
      - attempts: 5
      - interval: 10
