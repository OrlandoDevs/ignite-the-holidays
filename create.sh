#!/bin/bash

set -eu
set -o pipefail

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
SCRIPT_DIR=$(dirname ${SCRIPT_PATH})

# Get the topic from parameter or prompt
TOPIC=${1:-}
if [[ -z "$TOPIC" ]]; then
    read -p "Enter topic name: " TOPIC
fi

# Get random option from parameter or prompt
RANDOM_OPT=${2:-}
if [[ -z "$RANDOM_OPT" ]]; then
    read -p "Random order? (yes/no): " RANDOM_OPT
fi

SLIDES=${3:-20}

cat > /tmp/$$ <<EOF
[
    {
      "filename": "${TOPIC}.md",
      "attr":
      {
        "data-autoslide": 5000,
        "data-background": "#fffff",
        "data-background-image": "resources/images/ith-background.png"
      }
    },
EOF

i=1
# Get files based on random option
if [[ "$RANDOM_OPT" == "random" || "$RANDOM_OPT" == "yes" ]]; then
    FILES=$(find resources/images/${TOPIC} -type f | shuf -n ${SLIDES} --random-source /dev/random)
else
    FILES=$(find resources/images/${TOPIC} -type f | sort | head -n ${SLIDES})
fi

for file in $FILES
do
    if [[ ! -e slides/${i}.html ]]; then
	echo "" > slides/${i}.html
    fi
    echo "    {" >> /tmp/$$
    echo "        \"filename\": \"${i}.html\"," >> /tmp/$$
    echo "        \"attr\": {" >> /tmp/$$
    echo "            \"data-background-image\": \"${file}\"," >> /tmp/$$
    echo "            \"data-background-size\": \"contain\"" >> /tmp/$$
    echo "        }" >> /tmp/$$
    echo -n "   }" >> /tmp/$$
    i=$((i + 1))
    if [[ $i -le ${SLIDES} ]]; then
	echo "," >> /tmp/$$
    fi
done
echo "]" >> /tmp/$$

mv /tmp/$$ slides/list.json
