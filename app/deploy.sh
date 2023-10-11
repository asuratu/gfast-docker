#!/bin/bash
repo=git@codeup.aliyun.com:61b175c645bcdc5071135609/cloud/cloud-erp-service.git
dir=releases/$(date +%Y%m%d%H%M%S)
shared=shared
config=$shared/manifest/config.yaml

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
git clone -b dev  $repo "$dir" || exit 1

# config
if [ ! -f $config ]; then
  touch $config
fi

(cd "$dir" || exit;cp ../../$config manifest/config/config.yaml)

# makefile 执行打包

# current link
(rm -rf current && ln -sf "$dir" current)