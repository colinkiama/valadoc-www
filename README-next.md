# valadoc-www - A Valadoc.org spinoff

## Build Options

You can customise which Vala compiler you want to use by setting the `VALAC`
environment variable when running the meson commands.

## Quirks

### What does the generated libdoclet file do?

Generator program loads it dynamically. Valadoc uses it to generate documentation
content. Please do not change name of this file. Valadoc itself looks for it.

### There's a doclet header and vapi file but its unused

Meson doesn't provide a way to easily configure the library/module builds to disable
generation of vapi files and C Headers. Better to leave it alone until it actually
becomes a problem. The build script stays a lot simpler that way :)
