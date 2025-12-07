#!/bin/bash

set -euo pipefail

../ir_converter.sh --top=strip_fcs ./strip_fcs.x >strip_fcs.ir
../opt_main.sh strip_fcs.ir >strip_fcs.opt.ir
../codegen_main.sh strip_fcs.opt.ir >strip_fcs.v
