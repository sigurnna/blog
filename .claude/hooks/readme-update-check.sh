#!/bin/bash
# .claude 디렉토리 파일 변경 시 README.md 업데이트 요청
# PostToolUse hook에서 실행됨

set -e

# stdin에서 JSON 입력 받기
INPUT=$(cat)

# 파일 경로 추출
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

# 빈 경로면 종료
if [[ -z "$FILE_PATH" ]]; then
    exit 0
fi

# .claude 디렉토리 변경이 아니면 종료
if [[ "$FILE_PATH" != */.claude/* ]]; then
    exit 0
fi

# README.md 자체 수정은 무시 (무한 루프 방지)
if [[ "$FILE_PATH" == */README.md ]]; then
    exit 0
fi

# hooks 디렉토리 변경은 무시
if [[ "$FILE_PATH" == */.claude/hooks/* ]]; then
    exit 0
fi

# settings 파일 변경은 무시
if [[ "$FILE_PATH" == */.claude/settings*.json ]]; then
    exit 0
fi

# agents, commands, skills 디렉토리 변경만 감지
if [[ "$FILE_PATH" == */.claude/agents/* ]] || \
   [[ "$FILE_PATH" == */.claude/commands/* ]] || \
   [[ "$FILE_PATH" == */.claude/skills/* ]]; then

    # 변경된 파일 정보 추출
    FILENAME=$(basename "$FILE_PATH")
    DIRNAME=$(dirname "$FILE_PATH" | sed 's/.*\/.claude\///')

    # Claude에게 전달될 메시지 출력
    echo "[Hook] .claude/${DIRNAME}/${FILENAME} 파일이 변경되었습니다. .claude/README.md 업데이트가 필요할 수 있습니다."
fi

exit 0
