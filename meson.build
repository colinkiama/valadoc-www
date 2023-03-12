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

subdir('src/Docs')
subdir('src/Example')

# Create documentation generator
executable('generator', docs_generator_sources, dependencies: docs_generator_deps)

# Create Valadoc Doclet Module
shared_module (
    'doclet', doclet_module_sources, 
    dependencies: doclet_module_deps,
)

# Create example generator
executable('valadoc-example-gen', example_generator_sources, dependencies: example_generator_deps)

# Create example tester
executable('valadoc-example-tester', example_tester_sources, dependencies: examlpe_tester_deps)
