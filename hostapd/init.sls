{%- from "hostapd/map.jinja" import hostapd with context %}

include:
  - hostapd.install
  - hostapd.config
  - hostapd.service

