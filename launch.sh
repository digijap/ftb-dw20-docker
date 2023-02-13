#!/bin/bash

set -x

ID=101
VER=2336

cd /data

if ! [[ "$EULA" = "false" ]] || grep -i true eula.txt; then
        echo "eula=true" > eula.txt
else
        echo "You must accept the EULA by in the container settings."
        exit 9
fi

if ! [[ -f serverinstall_${ID}_${VER} ]]; then
  rm -f serverinstall_${ID}* forge-*.jar run.sh start.sh
  curl -Lo serverinstall_${ID}_${VER} https://api.modpacks.ch/public/modpack/${ID}/${VER}/server/linux
  chmod +x serverinstall_${ID}_${VER}
   yes | ./serverinstall_${ID}_${VER} --path /data --nojava --noscript
fi

if [[ -n "$MOTD" ]]; then
    sed -i "/motd\s*=/ c motd=$MOTD" /data/server.properties
fi

if [[ -n "$OPS" ]]; then
    echo $OPS | awk -v RS=, '{print}' > ops.txt
fi

if [[ -n "$ALLOWLIST" ]]; then
    echo $ALLOWLIST | awk -v RS=, '{print}' > white-list.txt
fi

sed -i 's/server-port.*/server-port=25565/g' server.properties

[[ -f run.sh ]] && chmod 755 run.sh
if [[ -f run.sh ]]; then
  if [[ -f user_jvm_args.txt ]]; then
    echo $JVM_OPTS > user_jvm_args.txt
  fi
  [[ -f run.sh ]] && ./run.sh
fi
