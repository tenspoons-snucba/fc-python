#!/bin/bash

path=$1

ls ${path}/*.in > ${path}/problems.txt
sed -e "s/\.\///g" ${path}/problems.txt > ${path}/problems.temp
mv $path/problems.temp $path/problems.txt
