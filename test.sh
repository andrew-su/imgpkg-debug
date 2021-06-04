#!/usr/bin/env bash

set +ex

# imgpkg push -b ${TEST_REGISTRY}/imgpkg-debug/staging:1.0 -f package_content/ --lock-output package.lock

mkdir -p staging/.imgpkg
kbld -f staging/config/app.yaml --imgpkg-lock-output staging/.imgpkg/images.yml
imgpkg push -b ${TEST_REGISTRY}/imgpkg-debug/staging:1.0 -f staging/ --lock-output staging.lock

imgpkg copy --lock staging.lock --to-repo ${TEST_REGISTRY}/imgpkg-debug/release --lock-output release.lock



imgpkg pull --lock package.lock -o extracted_bundle/package
imgpkg pull --lock staging.lock -o extracted_bundle/staging
imgpkg pull --lock release.lock -o extracted_bundle/release
