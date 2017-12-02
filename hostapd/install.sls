{%- from "hostapd/map.jinja" import hostapd with context %}

include:
  - hostapd.service

{%- if hostapd.atheros_firmware %}
hostapd_atheros_pkgs:
  pkg.installed:
    - pkgs: {{hostapd.atheros_pkgs}}
    - require_in:
      - pkg: hostapd_pkgs
    - watch_in:
      - service: hostpad_service
{%- endif %}

{%- if hostapd.realtek_firmware %}
hostapd_atheros_pkgs:
  pkg.installed:
    - pkgs: {{hostapd.realtek_pkgs}}
    - require_in:
      - pkg: hostapd_pkgs
    - watch_in:
      - service: hostpad_service
{%- endif %}

hostapd_pkgs:
  pkg.installed:
    - pkgs: {{hostapd.pkgs}}

