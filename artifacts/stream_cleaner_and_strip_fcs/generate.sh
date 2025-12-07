#!/bin/bash

set -euo pipefail

../ir_converter.sh --top=stream_cleaner_and_strip_fcs ./stream_cleaner_and_strip_fcs.x >stream_cleaner_and_strip_fcs.ir
../opt_main.sh stream_cleaner_and_strip_fcs.ir >stream_cleaner_and_strip_fcs.opt.ir
../codegen_main.sh stream_cleaner_and_strip_fcs.opt.ir >stream_cleaner_and_strip_fcs.v
