#!/bin/bash
# Path to typescript plugin
PROTOC_GEN_TS_PATH="./node_modules/.bin/protoc-gen-ts"

# Directory to write generated code to (.js and .d.ts files)
OUT_DIR=$1

mkdir -p $OUT_DIR

protoc \
    --plugin="protoc-gen-ts=${PROTOC_GEN_TS_PATH}" \
    --js_out="import_style=commonjs,binary:${OUT_DIR}" \
    --ts_out="${OUT_DIR}" \
    badge.proto

for filename in $(find $OUT_DIR -name "*_pb*"); do
    mv $filename $(echo $filename | sed -e "s/_pb//");
done
