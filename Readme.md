# Textadept 4.2 Settings For JavaScript and CoffeeScript Usage
## Linux Installation

- Download latest [textadept](http://code.google.com/p/textadept/downloads/list) and the latest modules pack
- Extract linux tarball somewhere sensible, and extract the modules pack on top of it
- Link the executable
- git clone this repository into /home/username/

## Assumed Requirements
- NodeJS
- CoffeeScript (globally installed)
- [node-jslint](https://github.com/reid/node-jslint) (globally installed)

## Notes
Based on the two modules:

- https://bitbucket.org/SirAlaran/ta-javascript/downloads
- https://github.com/rgieseke/ta-coffeescript

But both have been heavily edited:

- Build and Run working properly with both languages
- More/Better Snippets

## Build & Run
Integrated build and run all dump their result in an error buffer in split-view.

### CoffeeScript
- Build will compile to js (with -b to get matching stacktrace numbers from node)
- Run will run the .coffee file with coffee as a standalone module

### JavaScript
- Build will run the file with node-jslint
- Run will run the .js file with node as a standalone module


## Helpers
Unsplit & close script script bound to `ctrl-w` is contained in the main init.lua file.

Otherwise, I rely heavily on the bundled textadept awesomeness.
