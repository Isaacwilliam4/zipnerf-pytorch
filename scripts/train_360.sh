#!/bin/bash
# Copyright 2022 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

SCENE=counter
#EXPERIMENT=360_v2/"$SCENE"
EXPERIMENT=360_v2_test/"$SCENE"
DATA_ROOT=/SSD_DISK/datasets/360_v2
DATA_DIR="$DATA_ROOT"/"$SCENE"

# If running one of the indoor scenes, add
# --gin_bindings="Config.factor = 2"

rm exp/"$EXPERIMENT"/*
accelerate launch --main_process_port 1824 train.py --gin_configs=configs/360.gin \
  --gin_bindings="Config.data_dir = '${DATA_DIR}'" \
  --gin_bindings="Config.exp_name = '${EXPERIMENT}'" \
  --gin_bindings="Config.batch_size = 65536" \
  --gin_bindings="Config.factor = 8" \
  --gin_bindings="Config.render_chunk_size = 16384"
