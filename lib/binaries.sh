needs_resolution() {
  local semver=$1
  if ! [[ "$semver" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    return 0
  else
    return 1
  fi
}

install_nodejs() {
  local version="$1"
  local dir="$2"

  if needs_resolution "$version"; then
    echo "Resolving node version ${version:-(latest stable)} via semver.io..."
    local version=$(curl --silent --get -H "Authorization: Token 5ca196801173be06c7e6ce41d5f7b3b8071e680a" --data-urlencode "range=${version}" http://region.goodrain.me:8888/node/resolve)
    #local version="0.12.5"
  fi

  echo "Downloading and installing node $version..."
  #local download_url="http://s3pository.heroku.com/node/v$version/node-v$version-$os-$cpu.tar.gz"
  local download_url="http://lang.goodrain.me/node/v$version/node-v$version-linux-x64.tar.gz"
  curl "$download_url" -s -o - | tar xzf - -C /tmp
  mv /tmp/node-v$version-linux-x64/* $dir
  chmod +x $dir/bin/*
}

install_iojs() {
  local version="$1"
  local dir="$2"

  if needs_resolution "$version"; then
    echo "Resolving iojs version ${version:-(latest stable)} via semver.io..."
    version=$(curl --silent --get -H "Authorization: Token 5ca196801173be06c7e6ce41d5f7b3b8071e680a" --data-urlencode "range=${version}" http://region.goodrain.me:8888/iojs/resolve)
    #version="2.3.1"
  fi

  echo "Downloading and installing iojs $version..."
  #local download_url="https://iojs.org/dist/v$version/iojs-v$version-$os-$cpu.tar.gz"
  local download_url="http://lang.goodrain.me/iojs/v$version/iojs-v$version-linux-x64.tar.gz"
  curl $download_url -s -o - | tar xzf - -C /tmp
  mv /tmp/iojs-v$version-linux-x64/* $dir
  chmod +x $dir/bin/*
}

install_npm() {
  local version="$1"

  if [ "$version" == "" ]; then
    echo "Using default npm version: `npm --version`"
  else
    if needs_resolution "$version"; then
      echo "Resolving npm version ${version} via semver.io..."
      #version=$(curl --silent --get --data-urlencode "range=${version}" https://semver.herokuapp.com/npm/resolve)
      version="2.12.0"
    fi
    if [[ `npm --version` == "$version" ]]; then
      echo "npm `npm --version` already installed with node"
    else
      echo "Downloading and installing npm $version (replacing version `npm --version`)..."
      npm --registry http://registry.npm.taobao.org install --unsafe-perm --quiet -g npm@$version 2>&1 >/dev/null
    fi
  fi
}
