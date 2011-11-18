# Textadept 4.2 Settings For JavaScript and Coffee-Script Usage
## Linux Installation

- Download latest [textadept](http://code.google.com/p/textadept/downloads/list) and the latest modules pack
- Extract linux tarball somewhere sensible, and extract the modules pack on top of it
- Link the executable
- git clone this repository into /home/username/

## Notes
Based on the two modules:

- https://bitbucket.org/SirAlaran/ta-javascript/downloads
- https://github.com/rgieseke/ta-coffeescript


- extra keyboard shortcut taken out to insert snippets of js - was clashing with jump to
- tweaked run command and added compile shortcuts (line numbers of compiled correspond to node stacktraces)


## Build & Run
Proper added to the two modules above.
They all dump their result in an error buffer in split-view.

### CoffeeScript
- Build will compile to js
- Run will run the .coffee file with coffee as a standalone module

### JavaScript
- Build will run the file with node-jslint
- Run will run the .js file with node as a standalone module


## Helpers
Unsplit & close script script bound to `ctrl-w` is contained in the main init.lua file.

Otherwise, I rely heavily on the bundled textadept awesomeness.
