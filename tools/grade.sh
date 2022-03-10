#!/bin/bash

output_directory="my_output"
timeout=1

if [[ $# -lt 1 ]]
then
    echo "채점 프로그램은 1개 이상의 변수를 받습니다."
    echo "관리자에게 문의하세요."
    echo "사용법: grade.sh <과제명> [제한시간]"
    echo "제한시간이 설정되지 않는 경우 기본값은 1초입니다."
    exit 1
fi

# Set Timeout
if [[ $# -gt 1 ]]
then
    timeout=$2
fi

# Check if graded file is saved
task=$1
res=`ls "${task}.py" | wc -l`
if [[ $res -eq 0 ]]; then
    echo "채점될 파일이 저장되지 않았습니다. ${task}.py 파일이 있는지 확인하세요."
    exit 2
fi

# Check if test cases are downloaded
directory="./downloaded/${task}/testcase"
count=`ls ${directory}/*.in | wc -l`
if [[ $count -eq 0 ]]; then
    echo "채점에 사용될 테스트케이스가 발견되지 않았습니다."
    echo "테스트케이스를 다운로드했는지 확인하세요."
    echo "그럼에도 문제가 해결되지 않는다면 관리자에게 문의하세요."
    exit 3
fi

# Reset Grading Directory
rm -rf $output_directory
mkdir $output_directory

# Grading Process
i=0
## Start Message
echo "${count}개 테스트 케이스를 이용한 채점을 시작합니다"

# Iterate over input files
for input in `ls ${directory}/*.in`
do
    # Generate necessary variables
    i=$(($i + 1))
    output=`echo $input | cut -d "." -f2 | cut -d "/" -f5`
    output="${output}.out"

    # Generate Output and Compare
    echo "${count}개 중 ${i}번째 케이스 채점 중..."
    timeout ${timeout} python3 ${task}.py < ${input} > "./${output_directory}/${output}"
    diff -Z "${directory}/${output}" "./${output_directory}/${output}"
    if [[ $? -eq 1 ]]; then
        echo "${input} 테스트케이스를 실패했습니다."
        exit 1
    elif [[ $? -gt 1 ]]; then
        echo "오류가 발생했습니다."
        echo "관리자에게 문의하세요."
        exit $?
    fi
done

# No error means Successful Entry
echo "통과했습니다!"
exit 0
