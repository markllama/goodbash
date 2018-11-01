#!/bin/bash
#
# This script provides boilerplate and a template for well-behaved BASH scripts
#

# -----------------------------------------------------------------------------
# Parameters and Defaults
# -----------------------------------------------------------------------------

OPTSTRING="dhn"

declare -A DEFAULTS
DEFAULTS[DEBUG]='false'
DEFAULTS[HELP]='false'
DEFAULTS[DRYRUN]='false'

# ----------------------------------------------------------------------------
# Utility Functions
# ----------------------------------------------------------------------------

# List and describe the options
function usage() {
  cat <<EOF
USAGE: $0 [options]
  -d) debug: enable debugging output
  -h) help: print this text
  -n) noop: dry run, no side effects
EOF
}

# Configure this run from the CLI arguments
function process_cli() {
    
  # BASH builtin, not GNU getopt(1)
  while getopts $OPTSTRING OPT ; do
    case $OPT in
      d) DEBUG="true"
         ;;

      h) HELP="true" ; usage ;exit 0 ;;
            
      n) DRYRUN="true" ;;
            
      *)
        echo ERROR: invalid argument $OPT
        exit 2
        ;;
    esac
  done
}

# Set any values that have not been provided
function apply_defaults() {
  echo "apply defaults"
  for NAME in ${!DEFAULTS[*]} ; do
    # Only use default if not provided on the CLI
    if [ -z "${NAME}" ] then
       echo $(eval $NAME=\${DEFAULTS[$NAME]})
    fi
  done
}

# Execute (or print) callout commands.
# Use for stuff with side-effects for testing.
function run() {
  [ -n "${DRYRUN}" ] && RUN=echo || RUN=""
  $RUN $@
}

# =============================================================================
#
# Application Behavior Functions
#
# =============================================================================

# =============================================================================
#
# MAIN Function
#
# =============================================================================

function main() {
  
}

# =============================================================================
# Initialization Steps
# =============================================================================
process_cli $@
[ "$DEBUG" = 'true' ] && set -x
apply_defaults

main
