# Textadept 4.2 Settings For Coffee-Script Usage
## Linux Installation

- Download latest [textadept](http://code.google.com/p/textadept/downloads/list) and the latest modules pack
- Extract linux tarball somewhere sensible, and the modules pack over it
- Link the executable
- git clone this repository into /home/username/
- Profit.

Relies on the following modules:

- https://bitbucket.org/SirAlaran/ta-javascript/downloads
- https://github.com/rgieseke/ta-coffeescript

The CoffeeScript module has been modified to fit with later versions of textadept. In particular:

- extra keyboard shortcut taken out to insert snippets of js
- tweaked run command and added compile shortcuts


### Cool features
- `ctrl-r` will compile to js in a split-view
- `ctrl-w` will subsequently close this temporary buffer, and unsplit views
- `ctrl-shift-r` will run the .coffee file as a standalone module and demp the result in a split-view
- `ctrl-w` will similarly close the output buffer, and unsplit views

Unsplit script bound to `ctrl-w` is contained in the main init.lua file.

Otherwise, I recommend you rely on the bundled textadept awesomeness.
