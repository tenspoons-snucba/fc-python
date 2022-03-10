#!/bin/bash

# Settings
REPO="https://raw.githubusercontent.com/sailor1493/tenspoon-python/master"
TARBALL="tarball.tar"
GRADER="grade.sh"

# Command Check
if [[ $# -lt 1 ]]
then
  echo "설치 프로그램은 1개 이상의 변수를 받습니다."
  echo "관리자에게 문의하세요"
  echo "사용법 예시:"
  echo "  installer.sh task <과제명>"
  echo "  installer.sh grade"
  exit 1
fi
command=$1
if [[ $command = "grade" ]]
then
  echo "채점 프로그램 다운로드를 시작합니다."
  grade_repo="${REPO}/tools/${GRADER}"
  grade_local="./tools/${GRADER}"
  rm -f $grade_local
  wget -nv -O $grade_local $grade_repo
  chmod +x $grade_local
  echo "채점 프로그램이 다운로드되었습니다."
  exit 1
fi
if [[ $command != "task" ]]
then
  echo "지원하지 않는 명령어입니다."
  echo "지원하는 명령어: task, grade"
  echo "관리자에게 문의하세요."
  exit 1
fi
if [[ $# -ne 2 ]]
then
  echo "task 명령어는 2개의 명령인자를 받습니다."
  echo "사용법: installer.sh task <과제명>"
fi

# Set Variables
task=$2
return_path=$PWD
download_path="./downloaded/$task/testcase"
task_repo="${REPO}/${task}"
tarball_repo="${task_repo}/testcase/${TARBALL}"
tarball_local="${download_path}/${TARBALL}"

# Download Testcases
rm -rf $download_path
mkdir -p $download_path
wget -nv -O $tarball_local $tarball_repo
tar xf $tarball_local -C $download_path
rm -f $tarball_local
