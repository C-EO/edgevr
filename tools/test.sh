#!/bin/bash
#
# Using HTML-proofer to test site.
#
# Requirement: https://github.com/gjtorikian/html-proofer
#
# Usage: bash /path/to/test.sh
#
# v2.0
# https://github.com/cotes2020/jekyll-theme-chirpy
# © 2020 Cotes Chung
# MIT Licensed

DEST=_site
URL_IGNORE=cdn.jsdelivr.net

bundle exec htmlproofer $DEST \
  --disable-external \
  --check-html \
  --ignore_empty_alt \
  --ignore_missing_alt true \
  --enforce_https false \
  --allow_missing_href true \
  --ignore-urls $URL_IGNORE
