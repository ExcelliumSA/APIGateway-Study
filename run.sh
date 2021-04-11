#!/bin/bash
APIMAN_HOST=$1
echo -n "[+] Create HTTP BIN: "
bin_id=$(curl -s -X POST -d "private=false" https://requestbin.net/api/v1/bins | jq -r '.name')
echo $bin_id
echo "[+] APIMAN host: $APIMAN_HOST"
for venom_plan in $(ls *.yaml)
do
	echo "[+] Execute test plan: $venom_plan"
	bin_opts=""
	if [ "$(basename $venom_plan)" == "public-api-test-plan.yaml" ]; then
		bin_opt="--var=\"httpbin_id=$bin_id\""
	fi
	venom run --var="apiman_host=$APIMAN_HOST" $bin_opt --format="json" --output-dir="." $venom_plan
	echo "[+] Failed test cases:"
	cat test_results.json | jq --raw-output --sort-keys '.test_suites[].testcases[] | select(.failures != null).name'
done