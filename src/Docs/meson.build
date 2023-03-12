# Setup documentation generator variables
docs_generator_deps = [
    dependency('gee-0.8'),
    dependency('gio-2.0'),
    dependency('valadoc-@0@'.format(valadoc_version)),
]

docs_generator_sources = files(
    'Doclet.vala',
    'Generator.vala',
    'LinkHelper.vala',
)

doclet_module_deps = [
    dependency('gee-0.8'),
    dependency('valadoc-@0@'.format(valadoc_version)),
]

doclet_module_sources = files(
    'Doclet.vala',
    'LinkHelper.vala',
)