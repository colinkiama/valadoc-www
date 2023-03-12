project('valadoc-www', 'vala', 'c'
    version: '1.0.0'
)

valac =  meson.get_compiler('vala').cmd_array()[0]

libvala_version = run_command(valac, '--api-version').stdout().strip()