# valadoc-www - A Valadoc.org spinoff

## Build Options

You can customise which Vala compiler you want to use by setting the `VALAC`
environment variable when running the meson commands.

## Quirks

### What does the libdoclet file generated?

Generator program loads it dynamically. Valadoc uses it to generate documentation
content. Please do not change name of this file. Valadoc itself looks for it.
