# Textadept 4.2 Settings For Coffee-Script Usage
## Linux Installation

- Download latest [textadept](http://code.google.com/p/textadept/downloads/list) and the latest modules pack
- Extract linux tarball somewhere sensible, and extract the modules pack on top of it
- Link the executable
- git clone this repository into /home/username/

## Notes
Relies on the following modules:

- https://bitbucket.org/SirAlaran/ta-javascript/downloads
- https://github.com/rgieseke/ta-coffeescript

The CoffeeScript module has been modified to fit with later versions of textadept. In particular:

- extra keyboard shortcut taken out to insert snippets of js - was clashing with jump to
- tweaked run command and added compile shortcuts (line numbers of compiled correspond to node stacktraces)


## Cool features
- `ctrl-r` will compile to js in a split-view
- `ctrl-w` will subsequently close this temporary buffer, and unsplit views
- `ctrl-shift-r` will run the .coffee file as a standalone module and demp the result in a split-view
- `ctrl-w` will similarly close the output buffer, and unsplit views

Unsplit script bound to `ctrl-w` is contained in the main init.lua file.

Otherwise, I recommend you rely on the bundled textadept awesomeness.

