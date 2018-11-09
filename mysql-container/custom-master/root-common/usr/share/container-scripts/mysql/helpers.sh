function log_info {
  echo "---> `date +%T`     $@"
}

function log_warn {
  echo "---> `date +%T`     Warning: $@"
}

function log_and_run {
  log_info "Running $@"
  "$@"
}

function log_initialization {
  log_info "Running $@"
  AUTOGENERATED_ROOT_PASSWORD="$("$@" 2>&1 | grep "temporary password" | awk '{print $NF}')"
}

function log_volume_info {
  CONTAINER_DEBUG=${CONTAINER_DEBUG:-}
  if [[ "${CONTAINER_DEBUG,,}" != "true" ]]; then
    return
  fi

  log_info "Volume info for $@:"
  set +e
  log_and_run mount
  while [ $# -gt 0 ]; do
    log_and_run ls -alZ $1
    shift
  done
  set -e
  if [[ -v DEBUG_IGNORE_SCRIPT_FAILURES ]]; then
    set +e
  fi
}
