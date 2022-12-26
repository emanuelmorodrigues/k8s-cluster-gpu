#!/bin/bash

# get project and env args
while (( "$#" )); do
  case "$1" in
    --folder)
      FOLDER_TO_SHARE=$2
      shift 1
      ;;
    --) # end argument parsing
      shift
      break
      ;;
    -*|--*=)  # unsupported flags
      echo "Error: Unsupported flag $1" >&2
      exit 1
      ;;
    *)
    # preserve positional arguments
    PARAMS="$PARAMS $1"
    shift
    ;;
  esac
done


if [ -z "$FOLDER_TO_SHARE" ]
then
  echo "--folder is missing"
  exit 1
fi


sudo apt-get install nfs-kernel-server
sudo mkdir -p /srv/nfs/$FOLDER_TO_SHARE  # This directory will be used to share
sudo chown nobody:nogroup /srv/nfs/$FOLDER_TO_SHARE
sudo chmod 0777 /srv/nfs/kubedata
sudo echo '/srv/nfs/'${FOLDER_TO_SHARE}' *(rw,sync,no_subtree_check,no_root_squash,no_all_squash,insecure)' | sudo tee /etc/exports
sudo systemctl restart nfs-kernel-server
