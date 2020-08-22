/root/podman.te:
  file.managed:
    - source: salt://selinux/policies/podman.te
    - force: true

build_selinux_podman_te_into_module:
  cmd.run:
    - name: checkmodule -M -m -o podman.mod podman.te
    - cwd: "/root"

build_podman_te_module_into_pp_file:
  cmd.run:
    - name: semodule_package -o podman.pp -m podman.mod
    - cwd: "/root"

remove_existing_podman_policy:
  cmd.run:
    - name: semodule -r podman
    - success_retcodes:
      - "0"
      - "1"

load_podman_pp_file:
  cmd.run:
    - name: semodule -i podman.pp
    - cwd: "/root"
