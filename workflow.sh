#!/bin/bash

./dataPull.sh 

./dataTransfer.sh 

python3 dataAnalysis.py

python3 mdWriter.py