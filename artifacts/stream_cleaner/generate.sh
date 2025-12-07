#!/bin/bash

set -euo pipefail

../ir_converter.sh --top=stream_cleaner ./stream_cleaner.x >stream_cleaner.ir
../opt_main.sh stream_cleaner.ir >stream_cleaner.opt.ir
../codegen_main.sh stream_cleaner.opt.ir >stream_cleaner.v
