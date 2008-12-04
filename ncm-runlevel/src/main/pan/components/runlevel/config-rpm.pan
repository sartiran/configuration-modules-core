# ${license-info}
# ${developer-info}
# ${author-info}

# Coding style: emulate <TAB> characters with 4 spaces, thanks!
################################################################################

unique template components/runlevel/config-rpm;
include components/runlevel/schema;

# Package to install
"/software/packages"=pkg_repl("ncm-runlevel","1.0.1-1","noarch");
 
"/software/components/runlevel/dependencies/pre" ?= list("spma");
"/software/components/runlevel/active" ?= true;
"/software/components/runlevel/dispatch" ?= true;
 
