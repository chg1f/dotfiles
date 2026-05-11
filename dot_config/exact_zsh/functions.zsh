#!zsh

uuid() {
  local version=4 compress=

  for arg in "$@"; do
    case "$arg" in
    -4) version=4 ;;
    -7) version=7 ;;
    -c | --compress) compress=.hex ;;
    *)
      echo "usage: uuid [-4|-7] [-c|--compress]" >&2
      return 1
      ;;
    esac
  done

  python3 -c "import uuid; print(uuid.uuid${version}()${compress})"
}
