remove_kernel_headers:
  pkg.removed:
    - pkgs:
      - kernel-headers

kernel_mainline:
  pkg.installed:
    - pkgs:
      - kernel-ml
      - kernel-ml-headers
      - kernel-ml-devel
    - enablerepo: elrepo-kernel
    - require:
      - pkg: elrepo
      - pkg: remove_kernel_headers

set_kernel_mainline_as_default:
  file.replace:
    - name: /etc/default/grub
    - pattern: '^(GRUB_DEFAULT=).*'
    - repl: '\g<1>0'
    - require:
      - pkg: kernel_mainline
  cmd.run:
    - name: grub2-mkconfig -o /boot/grub2/grub.cfg
    - onchanges:
      - file: set_kernel_mainline_as_default
