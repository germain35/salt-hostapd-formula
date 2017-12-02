{%- from "hostapd/map.jinja" import hostapd with context %}

include:
  - hostapd.install
  - hostpad.config
  - hostapd.service

