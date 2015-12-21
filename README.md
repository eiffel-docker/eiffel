Docker containers for Eiffel Programming Language:

## https://hub.docker.com/r/eiffel/eiffel/ with tags 
   -  "latest" or "15.08" which is a debian machine with latest official release of EiffelStudio  (15.08 for now)
   -  "15.11-dev" which is a debian machine with latest "dev" release of EiffelStudio  (15.11.98242 for now)

## https://hub.docker.com/r/eiffel/dev/ with tags
   - "latest" from container "eiffel/eiffel:latest" and additional tools like tmux, subversion, git, vim, ...
   - "trunk" from container "eiffel/eiffel:dev" , similar to eiffel/dev:latest  except it checkouts the eiffelstudio source code  (trunk), and set EIFFEL_SRC, and ISE_LIBRARY accordingly.

## https://hub.docker.com/r/eiffel/iron/ with tag
   - "latest": from eiffel/dev:trunk container, its compiles an iron repository server, and run it listening on port 9090.  It also provides via $HOME/iron/scripts/iron_fill_trunk.sh  a way to upload iron packages from the EiffelStudio source code (trunk) into that local iron server.
   - "trunk": from eiffel/iron:latest container, it uploads iron package from $EIFFEL_SRC to the local iron repository server.

