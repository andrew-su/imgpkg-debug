#!/usr/bin/env bash

set +e

# imgpkg push -b ${TEST_REGISTRY}/imgpkg-debug/staging:1.0 -f package_content/ --lock-output package.lock

mkdir -p release/.imgpkg
kbld -f release/config/app.yaml --imgpkg-lock-output release/.imgpkg/images.yml
imgpkg push -b ${TEST_REGISTRY}/imgpkg-debug/bundle2:1.0 -f release/ --lock-output staging.lock

imgpkg copy --lock staging.lock --to-repo ${TEST_REGISTRY}/imgpkg-debug/release --lock-output release.lock



imgpkg pull --lock package.lock -o extracted_bundle/package
imgpkg pull --lock staging.lock -o extracted_bundle/staging
imgpkg pull --lock release.lock -o extracted_bundle/release
