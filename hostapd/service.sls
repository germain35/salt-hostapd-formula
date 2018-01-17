{%- from "hostapd/map.jinja" import hostapd with context %}

include:
  - hostapd.install

hostapd_service:
  service.running:
    - name: {{hostapd.service}}
    - enable: {{hostapd.service_enabled}}
    - reload: {{hostapd.service_reload}}
    - require:
      - pkg: hostapd_pkgs
