# Setup documentation generator variables
docs_generator_deps = [
    dependency('gee-0.8'),
    dependency('gio-2.0'),
    dependency('valadoc-@0@'.format(valadoc_version)),
    dependency('template-glib-1.0'),
]

config_vala = configure_file(
    input: 'Config.vala.in',
    output: 'Config.vala',
    configuration: conf_data,
)

docs_generator_sources = [
    files(
        'Doclet.vala',
        'Generator.vala',
        'LinkHelper.vala',
    ),
    config_vala,
]

doclet_module_deps = [
    dependency('gee-0.8'),
    dependency('valadoc-@0@'.format(valadoc_version)),
    dependency('template-glib-1.0'),
]

doclet_module_sources = [
    files(
        'Doclet.vala',
        'LinkHelper.vala',
    ),
    config_vala,
]