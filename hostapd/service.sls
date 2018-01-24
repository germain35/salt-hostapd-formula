{%- from "hostapd/map.jinja" import hostapd with context %}

include:
  - hostapd.install

{%- if hostapd.service_running %}

hostapd_service:
  service.running:
    - name: {{hostapd.service}}
    - enable: {{hostapd.service_enabled}}
    - reload: {{hostapd.service_reload}}
    - require:
      - pkg: hostapd_pkgs

{%- else %}

hostapd_service:
  service.dead:
    - name: {{hostapd.service}}
    - enable: {{hostapd.service_enabled}}
    - require:
      - pkg: hostapd_pkgs

{%- endif %}