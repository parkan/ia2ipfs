#!/bin/bash

# usage: ./ia2ipfs.sh dweb-8_2_18_Hash_Lounge_DataStewardshipontheDecentralizedWeb [h.264]

ID=$1
FORMAT=${2:-"h.264"}
LEAFURL=https://gateway.dweb.me/arc/archive.org/leaf/${ID}
METADATA_PATH=$(curl -s $LEAFURL | jq -r ".[] | fromjson | .urls | .[] | select(startswith(\"ipfs\"))")
METADATA_CID=${METADATA_PATH#"ipfs:"}
echo "metadata CID: ${METADATA_CID}"
FILENAME=$(ipfs cat ${METADATA_CID} | jq -r ".files | .[] | select(.format==\"${FORMAT}\") | .name")
MEDIA_PATH=$(curl -s "https://gateway.dweb.me/arc/archive.org/metadata/${ID}/${FILENAME}" | jq -r ".ipfs")
MEDIA_CID=${MEDIA_PATH#"ipfs:"}
echo "media CID: ${MEDIA_CID}"
