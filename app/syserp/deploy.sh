#!/bin/bash
repo=git@codeup.aliyun.com:61b175c645bcdc5071135609/cloud/erp-admin-service.git
dir=releases/$(date +%Y%m%d%H%M%S)

makefile() {
  path=$1
  mf=makefile
  mf_path="$path"/$mf
  cp -f ${mf}.in "$mf_path"

  if [ "$2" == "prod" ]; then
    dev="--no-dev"
  fi

  uname=$(uname -v)
  os=${uname:0:6}
  case ${os} in
  'Darwin')
    sed -i '' "s/%dev%/$dev/g" "$mf_path"
    sed -i '' 's/%webuser%/staff/g' "$mf_path"
    ;;
  *)
    sed -i "s/%dev%/$dev/g" "$mf_path"
    sed -i 's/%webuser%/www-data/g' "$mf_path"
    ;;
  esac
  return 0
}

# git
git clone -b main  $repo "$dir" || exit 1

# current link
(rm -rf current && ln -sf "$dir" current)

# config link
(cd "shared/manifest" || exit; rm -rf config && ln -sf "../../$dir/manifest/config" config)

# 复制 config.yaml.example 到 config.yaml
(cd "current/manifest/config" || exit;cp config.yaml.example config.yaml)

# 执行打包
(cd "$dir" || exit;go build -o main;supervisorctl restart syserp)
