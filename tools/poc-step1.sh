#!/bin/bash

echo "1단계 파일을 성공적으로 실행했습니다."
echo
echo "2단계 파일을 다운로드합니다."
rm -f poc-step2.sh
wget -nv -O poc-step2.sh https://raw.githubusercontent.com/sailor1493/tenspoon-python/master/tools/poc-step2.sh
echo "2단계 파일이 다운로드되었는지 확인합니다."
echo "검색 후 1개의 결과가 나와야 합니다."
chmod +x poc-step2.sh
ls -al | grep "poc-step2.sh"

echo "2단계 파일을 실행합니다."
./poc-step2.sh
