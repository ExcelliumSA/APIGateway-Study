#!/bin/bash
APIMAN_HOST=$1
if [ "$APIMAN_HOST" == "" ]; then
	echo "Missing APIMAN host!"
	exit -1
fi
echo "[+] APIMAN host: $APIMAN_HOST"
echo "[+] Setup APIMAN instance:"
python import-config.py $APIMAN_HOST
echo -n "[+] Create HTTP BIN: "
bin_id=$(curl -s -X POST -d "private=false" https://requestbin.net/api/v1/bins | jq -r '.name')
echo $bin_id
echo "[+] Test HTTP BIN: "
curl "https://requestbin.net/r/$bin_id"
echo "[+] Execute test plan for PUBLISHED API:"
venom_plan="published-api-test-plan.yaml"
venom run --var="apiman_host=$APIMAN_HOST" --format="json" --output-dir="." $venom_plan
echo "[+] Failed test cases:"
cat test_results.json | jq --raw-output --sort-keys '.test_suites[].testcases[] | select(.failures != null).name'
echo "[+] Execute test plan for PUBLIC API:"
venom_plan="public-api-test-plan.yaml"
venom run --var="apiman_host=$APIMAN_HOST" --var="httpbin_id=$bin_id" --format="json" --output-dir="." $venom_plan
echo "[+] Failed test cases:"
cat test_results.json | jq --raw-output --sort-keys '.test_suites[].testcases[] | select(.failures != null).name'
