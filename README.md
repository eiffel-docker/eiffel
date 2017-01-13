Docker containers for Eiffel Programming Language:
notes: about tag conventions:
  - latest: related to Latest EiffelStudio official release.
  - dev: related to latest EiffelStudio "dev" release 
  		and ISE_LIBRARY is set to EIFFEL_SRC (a checkout of EiffelStudio trunk source code).

## https://hub.docker.com/r/eiffel/eiffel/ with tags 
   -  "latest" which is a debian machine with latest official release of EiffelStudio  (17.01 for now)
   -  "dev" which is a debian machine with latest "dev" release of EiffelStudio  (See ftp://ftp.eiffel.com/pub/beta/nightly/ )

## https://hub.docker.com/r/eiffel/develop/ with tags
   - "latest" from container "eiffel/eiffel:latest" and additional tools like tmux, subversion, git, vim, ...
   - "dev": similar to "latest", but built from container "eiffel/eiffel:dev" and except it checkouts the eiffelstudio source code  (trunk), and set EIFFEL_SRC, and ISE_LIBRARY accordingly.

## https://hub.docker.com/r/eiffel/iron/ with tags
   - "latest": from eiffel/develop:trunk container, its compiles an iron repository server, and run it listening on port 9090.  It also provides via $HOME/iron/scripts/iron_fill_trunk.sh  a way to upload iron packages from the EiffelStudio source code (trunk) into that local iron server.
   - "trunk": from eiffel/iron:latest container, in addition it uploads iron packages from $EIFFEL_SRC to the local iron repository server.

