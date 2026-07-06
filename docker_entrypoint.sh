#!/usr/bin/env bash

echo "Running locust"
echo "USER_WAIT_TIME_MIN_SECONDS=${USER_WAIT_TIME_MIN_SECONDS} \
USER_WAIT_TIME_MAX_SECONDS=${USER_WAIT_TIME_MAX_SECONDS} REQUESTS_JSON=${REQUESTS_JSON} \
HOST=${HOST} INCLUDE_SCHEMA_URL_IN_TOKEN=${INCLUDE_SCHEMA_URL_IN_TOKEN}"
echo "locust ${LOCUST_OPTS:-}"

read -r -a locust_opts <<<"${LOCUST_OPTS:-}"

USER_WAIT_TIME_MIN_SECONDS=${USER_WAIT_TIME_MIN_SECONDS} \
    USER_WAIT_TIME_MAX_SECONDS=${USER_WAIT_TIME_MAX_SECONDS} \
    REQUESTS_JSON=${REQUESTS_JSON} HOST=${HOST} \
    INCLUDE_SCHEMA_URL_IN_TOKEN=${INCLUDE_SCHEMA_URL_IN_TOKEN} \
    locust "${locust_opts[@]}"

if [[ -n ${GCS_OUTPUT_BUCKET} ]]; then
    echo "Storing benchmark outputs"
    python -m scripts.store_benchmark_outputs
fi
