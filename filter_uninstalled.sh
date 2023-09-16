function dnfind() {
  local query
  local dnf_results
  local system_installed

  query=$1
  # If no query is provided, print an error message
  if [ -z "$query" ]; then
    echo "No query provided"
    return 1
  fi

  dnf_results=$(dnf search cockpit | sed -E 's/(:).+//i' | grep cockpit)
  system_installed=$(dnf list installed | grep cockpit | sed -E 's/(:).+//i' | grep cockpit)

  echo "$dnf_results"
  echo "$system_installed"
  return 1
}

alias dnfind=dnfind
dnfind "$1"

# sed -E 's/(\s.+).*//'
