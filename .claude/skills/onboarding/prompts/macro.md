# Macro Analyst 프롬프트 (Light)

## Task 호출

```
Task(
  subagent_type="macro-analyst",
  description="[티커] 매크로/산업 조사",
  prompt="아래 프롬프트 내용"
)
```

---

## 프롬프트 템플릿

```
[티커] 기업이 속한 산업과 매크로 환경을 간략히 조사해주세요.

수집 항목 (핵심만):
1. 산업 개요 (한 문단)
2. 산업 성장률 (CAGR)
3. 주요 트렌드 1-2개
4. Lynch 분류 (Fast Grower/Stalwart/Cyclical 등)

Agent 지침: .claude/agents/collectors/macro.md 참조
출력 파일: reports/[티커]/onboarding/2_macro.md
출력 형태: 간략한 텍스트

⚠️ 조사 완료 후 반드시 위 경로에 파일 저장. 메인에는 "완료" 메시지만 반환.
```

---

## 수집 항목 상세

| 항목 | 설명 | 필수 |
|------|------|------|
| 산업 개요 | 어떤 산업인지 한 문단 | ✅ |
| CAGR | 산업 성장률 | ⚪ |
| 주요 트렌드 | 1-2개 핵심 트렌드 | ✅ |
| Lynch 분류 | Fast Grower/Stalwart/Cyclical/Asset Play 등 | ✅ |
