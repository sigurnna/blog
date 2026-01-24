# Business Model Analyst 프롬프트 (Light)

## Task 호출

```
Task(
  subagent_type="business-model-analyst",
  description="[티커] 비즈니스 모델 조사",
  prompt="아래 프롬프트 내용"
)
```

---

## 프롬프트 템플릿

```
[티커] 기업의 비즈니스 모델을 간략히 조사해주세요.

수집 항목 (핵심만):
1. 핵심 사업 한 줄 정의
2. 수익 모델 (구독/거래/라이선스/하드웨어 등)
3. 주요 고객군 (B2B/B2C/정부)
4. 시장 규모 (TAM/SAM)

Agent 지침: .claude/agents/collectors/business.md 참조
출력 파일: reports/[티커]/onboarding/1_business.md
출력 형태: 간략한 텍스트 (테이블 최소화)

⚠️ 조사 완료 후 반드시 위 경로에 파일 저장. 메인에는 "완료" 메시지만 반환.
```

---

## 수집 항목 상세

| 항목 | 설명 | 필수 |
|------|------|------|
| 핵심 사업 | 회사가 무엇을 하는지 한 문장 | ✅ |
| 수익 모델 | 어떻게 돈을 버는지 | ✅ |
| 고객군 | 누구에게 파는지 | ✅ |
| TAM/SAM | 시장 규모 | ⚪ |
