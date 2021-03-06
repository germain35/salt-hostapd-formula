{%- from "hostapd/map.jinja" import hostapd with context %}

include:
  - hostapd.service

{%- if hostapd.get('interfaces', {}).keys()|length > 1 %}

  {%- macro interface2conf(interface, hostpad) -%}
    {{ hostapd.conf_dir }}/{{ hostapd.conf_file|replace('.conf', "_{}.conf".format(interface)) }}
  {%- endmacro %}

hostapd_activate:
  file.replace:
    - name: {{ hostapd.defaults_file }}
    - pattern: "^[#]{0,}DAEMON_CONF=.*$"
    - repl: "DAEMON_CONF='{% for interface in hostapd.get('interfaces', {}).keys() %}{{ interface2conf(interface, hostapd) }} {% endfor %}'"
    - watch_in:
      - service: hostapd_service

  {%- for interface in hostapd.get('interfaces', {}).keys() %}
hostapd_config_{{interface}}:
  file.managed:
    - name: {{ interface2conf(interface, hostapd) }}
    - source: salt://hostapd/templates/hostapd.conf.jinja
    - template: jinja   
    - user: {{ hostapd.user }}
    - group: {{ hostapd.group }}
    - mode: {{ hostapd.mode }}  
    - makedirs: True
    - context:
        interface: {{interface}}
    - watch_in:
      - service: hostapd_service
    - require:
      -  file: hostapd_activate
  {%- endfor %}

{%- else %}

hostapd_activate:
  file.replace:
    - name: {{ hostapd.defaults_file }}
    - pattern: "^[#]{0,}DAEMON_CONF=.*$"
    - repl: "DAEMON_CONF='{{ hostapd.conf_dir|path_join(hostapd.conf_file) }}'"
    - watch_in:
      - service: hostapd_service

  {%- for interface in hostapd.get('interfaces', {}).keys() %}
hostapd_config_{{interface}}:
  file.managed:
    - name: {{ hostapd.conf_dir|path_join(hostapd.conf_file) }}
    - source: salt://hostapd/templates/hostapd.conf.jinja
    - template: jinja   
    - user: {{ hostapd.user }}
    - group: {{ hostapd.group }}
    - mode: {{ hostapd.mode }}  
    - makedirs: True
    - context:
        interface: {{interface}}
    - watch_in:
      - service: hostapd_service
    - require:
      -  file: hostapd_activate
  {%- endfor %}

{%- endif %}