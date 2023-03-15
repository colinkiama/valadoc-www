# valadoc-www - A Valadoc.org spinoff

Learn Vala, do future.

This project generates a version of the valadoc.org website that is statically generated.

The goal is for people to easily have a local copy of valadoc.org,
that can also be statically hosted and can easily be experimented on.

## Build Instructions

In order to build the docs you will need the following:

- `valadoc` >= 0.35.0
- Node.js (LTS Version) - We recommend using [nvm](https://github.com/nvm-sh/nvm) or [nvm-windows](https://github.com/coreybutler/nvm-windows) for easily managing different node versions.
- 4 GB of free space

On elementary OS or Ubuntu run:

```bash
sudo add-apt-repository ppa:vala-team
sudo apt update
sudo apt install valac valadoc libvaladoc-dev unzip
```

Arch or derivatives run:

```bash
pacman -S vala php
```

Next, install JS dependencies:

After you have `valadoc` installed, you can move to building the documentation.

First make sure that you are currently the root of the project.

Also, there's a chance that these build scripts may not be have permissions to run at first. Run the following command to give the build scripts executable permissions so that they can run on your machine:

```sh
chmod +x ./task/*
```

Now, to build the programs and assets needed to generated the website run this command:

```sh
./task/build
```

Now run this command to generate the website:

```sh
./task/run
```

This may take a while since it's generating documentation for a lot of packages. Here are some alternative commands to run if you only need documentation for a specific set of packages:

(List the preset commands)

## Development Commands

Build:

```sh
./task/build
```

Run generator:

```sh
./task/run
```

Clean Project:

```sh
./task/clean
```

## Build Options

You can customise which Vala compiler you want to use by setting the `VALAC`
environment variable when running the meson commands.

## Add New Packages

Open `documentation/packages.xml` and add a new package-entry.

Use `<external-package>` to create external links:

```xml
<external-package name="package-name" link="http://path/to/docs">
  short description
</external-package>
```

Use `<package>` to build and include documentation for vapi files:

```xml
<package name="gdl-1.0">
  short description
</package>
```

The following attributes are supported:

| Name              | Description                                        |
| ----------------- | -------------------------------------------------- |
| name              | The vapi name                                      |
| deprecated        | Set it to '"true"' to mark a package as deprecated |
| maintainers       | List of binding maintainers                        |
| gir               | The GIR file used to extract documentation from    |
| c-docs            | Link to C documentation                            |
| ignore            | Do not build documentation for this entry          |
| home              | Homepage link                                      |
| flags             | Additional vala flags (Missing dependencies, ...)  |
| gallery           | Link to a GTK-Doc widget gallery                   |
| vapi-image-source | Source to download images from                     |

Referenced GIR and vapi-files have to be part of one of the following repositories:

- [vala](http://vala-project.org/)
- [vala-girs](https://github.com/nemequ/vala-girs)
- [vala-extra-vapis](https://gitlab.gnome.org/GNOME/vala-extra-vapis)

## Add New Source Code Examples

Copy your examples to `examples/<vapi-name>/` and add a new entry to `examples/<vapi-name>/<vapi-name>.valadoc.examples`:

```xml
<example>
  <title>Example Title</title>
  <image>optional-screenshot.png</image>
  <file>file-name-1.vala</file>
  <file>file-name-2.vala</file>
  <compile>valac file-name1.vala file-name-2.vala ...</compile>
  <node>Associated.Symbol.name1</node>
  <node>Associated.Symbol.name2</node>
</example>
```

If this is the first example for the package, add a line to the `check-examples` target of `Makefile`.

## Add Handwritten Documentation

Create a new file called `<vapi-name>.valadoc` in `documentation/<vapi-name>/`:

```
...

/**
 * My valadoc comment
 */
c::c_symbol_name
```

```
...

/**
 * My valadoc comment
 */
Vala.Symbol.Name
```

## Tool Overview

- _generator:_ Parses `packages.xml` files describing all packages. It is responsible for building
  up the page. It fetches resources such as images from specified sources, computes valadoc-calls,
  builds documentation for specified packages and puts-together the whole page. (`make serve`, `make serve-mini`)
- _configgen:_ Used to generate configuration files for our search index.
- _valadoc-example-gen:_ Internally used to generate example listings.
- _valadoc-example-tester:_ Compiles and checks all registered examples. (`make test-examples`)

## Common Pitfalls

`error: failed to load driver`

- Your valadoc version does not support the requested vala version. Install a recent vala version and
  recompile valadoc.
- Change `VALAC_VERSION` in Makefile.

Other errors:

- Check `LOG` in the root of this repo for more information
- Have you run out of disk space?

## Quirks

### What does the generated libdoclet file do?

Generator program loads it dynamically. Valadoc uses it to generate documentation
content. Please do not change name of this file. Valadoc itself looks for it.

### There's a doclet header and vapi file but it's unused

Meson doesn't provide a way to easily configure the library/module builds to disable
generation of vapi files and C Headers. Better to leave it alone until it actually
becomes a problem. The build script stays a lot simpler this way :)

## Contact And Help

- [Git Repository](https://github.com/colinkiama/valadoc-www)
- [Issue Tracker, valadoc.org](https://github.com/colinkiama/valadoc-www/issues)
- [Issue Tracker, valadoc (now a part of Vala)](https://gitlab.gnome.org/GNOME/vala/issues)
- IRC: irc.gnome.org, #vala (flo, UTC+01:00)
- Mail: colinkiama@gmail.com
