[uwsgi]
need-app = true
http-socket = :{{ .Values.masakariApiPortInternal }}
uid = masakari
gid = masakari
lazy-apps = true
add-header = Connection: close
buffer-size = 65535
hook-master-start = unix_signal:15	# gracefully_kill_them_all
thunder-lock = true
enable-threads = true
worker-reload-mercy = 90
exit-on-reload = false
die-on-term = true
master = true
memory-report = true
processes = {{ .Values.uwsgi.processes }}
wsgi-file = {{ .Values.uwsgi.wsgi_file }}

