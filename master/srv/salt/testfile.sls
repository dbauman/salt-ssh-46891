mytestfile:
  file.managed:
    - name: /root/HELLO
    - source: salt://HELLO
    - template: jinja
    
