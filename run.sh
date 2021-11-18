#!/bin/bash

for d in test/integration/*/ ; do

    pipeline="${d}pipeline.ttl"
    actual="${d}actual_output.nt"
    expected="${d}expected_output.nt"

    if test -f "$pipeline"; then

      if test -f "$actual"; then
        rm $actual
      fi

      node node_modules/.bin/barnard59 run "$pipeline" \
        --pipeline http://example.com/pipelines/main \
        --output "$actual"

      if ! test -f "$actual"; then
        printf "[$d] $actual missing.  ❌ fail\n"
        exit 1
      fi

      if test -f "$expected"; then
        if cmp -s "$actual" "$expected"; then
          printf "[$d] ✅ pass\n"
        else
          printf "[$d] The file $actual is different than $expected. ❌ fail\n"
          exit 1
        fi
      else
        echo "WARNING: no $expected found."
      fi
    fi
done
