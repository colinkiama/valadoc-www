project('valadoc-www', 'vala', 'c',
    version: '1.0.0'
)

valac = meson.get_compiler('vala')
valac_version = get_option('valac_version')

if valac_version == ''
    valac_version = run_command(valac.cmd_array()[0], '--api-version', check: true).stdout().strip() 
endif

valadoc_version = get_option('valadoc_version')

if valadoc_version == ''
    valadoc_version = valac_version
endif

vala_vapi_dir = run_command('pkg-config', '--variable', 'vapidir', 'libvala-@0@'.format(valac_version), check: true)
vala_flags = '-g -X -w'

# Create generator
subdir('src/Generator')
executable('generator', generator_sources, dependencies: generator_deps)

# Create Valadoc Doclet Module
shared_module('libdoclet', doclet_module_sources, dependencies: doclet_module_deps)

# subdir('src/Example')