{%- from "hostapd/map.jinja" import hostapd with context %}

include:
  - hostapd.service

hostapd_config:
  file.managed:
    - name: {{ hostapd.conf_file }}
    - source: salt://hostapd/templates/hostapd.conf.jinja
    - template: jinja   
