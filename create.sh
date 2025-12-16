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

# Get mode option from parameter or prompt
MODE=${2:-}
if [[ -z "$MODE" ]]; then
    read -p "Mode (light/dark): " MODE
fi

# Get random option from parameter or prompt
RANDOM_OPT=${3:-}
if [[ -z "$RANDOM_OPT" ]]; then
    read -p "Random order? (yes/no): " RANDOM_OPT
fi

SLIDES=${4:-20}

# Set background and color based on mode
if [[ "$MODE" == "dark" ]]; then
    BACKGROUND_IMAGE="resources/images/ith-black-background.png"
    HEADING_COLOR="#fff"
else
    BACKGROUND_IMAGE="resources/images/ith-background.png"
    HEADING_COLOR="#444"
fi

cat > /tmp/$$ <<EOF
[
    {
      "filename": "${TOPIC}.md",
      "attr":
      {
        "data-autoslide": 5000,
        "data-background": "#fffff",
        "data-background-image": "${BACKGROUND_IMAGE}"
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

# Count actual number of files
FILE_COUNT=$(echo "$FILES" | wc -l)

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
    if [[ $i -lt ${FILE_COUNT} ]]; then
	echo "," >> /tmp/$$
    fi
    i=$((i + 1))
done
echo "]" >> /tmp/$$

mv /tmp/$$ slides/list.json

# Update template with heading color based on mode
sed -i "s/color: #[0-9a-fA-F]\{3,6\};/color: ${HEADING_COLOR};/" templates/_index.html
