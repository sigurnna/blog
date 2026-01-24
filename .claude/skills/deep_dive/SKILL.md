---
name: deep_dive
description: 특정 종목에 대한 심층 분석. 4개 Collector로 팩트 수집 후, 7개 Interpreter의 다각도 해석을 거쳐 중립적 종합 리포트를 생성합니다.
user-invocable: true
---

# /deep-dive [티커]

> 특정 종목에 대한 심층 분석 워크플로우

## 목적

4개 Collector로 **팩트 수집** 후, 7개 Interpreter의 **다각도 해석**을 거쳐 **중립적 종합 리포트**를 생성한다.

## 사용법

```
/deep-dive IREN
/deep-dive PLTR
```

---

## 핵심 원칙

1. **Task 도구 필수**: 모든 Agent는 Task 도구로 실행 (메인 컨텍스트 절약)
2. **병렬 실행**: 단계 내 Agent들을 **단일 메시지에서 동시 호출**
3. **파일 저장**: 서브에이전트 결과는 파일로 저장, 메인에는 "완료"만 반환
4. **팩트/해석 분리**: Collector는 팩트만, Interpreter는 해석만

---

## 워크플로우 요약

```
[1단계: 팩트 수집] - 4개 Collector 병렬
    ├─ financial-analyst       → 1_financial.md
    ├─ business-model-analyst  → 2_business.md
    ├─ competitive-moat-analyst→ 3_moat.md
    └─ macro-analyst           → 4_macro.md
              │
[2단계: 팩트 통합]
    └─ report-synthesizer      → 5_synthesized.md
              │
[3단계: 다각도 해석] - 7개 Interpreter 병렬
    ├─ sesang-interpreter      → 6_sesang.md
    ├─ cathie-wood-interpreter → 6_cathie_wood.md
    ├─ michael-burry-interpreter → 6_michael_burry.md
    ├─ terry-smith-interpreter → 6_terry_smith.md
    ├─ howard-marks-interpreter→ 6_howard_marks.md
    ├─ druckenmiller-interpreter → 6_druckenmiller.md
    └─ bill-ackman-interpreter → 6_bill_ackman.md
              │
[4단계: 중립 종합]
    └─ vote-aggregator         → 7_final.md
```

상세: [워크플로우](workflow.md)

---

## 출력 파일 구조

```
reports/[티커]/YYYY-MM-DD/
├── 1_financial.md      # 재무 팩트시트
├── 2_business.md       # 비즈니스 모델 팩트시트
├── 3_moat.md           # 경쟁 우위 팩트시트
├── 4_macro.md          # 매크로 팩트시트
├── 5_synthesized.md    # 통합 팩트시트
├── 6_*.md              # Interpreter별 해석 (7개)
└── 7_final.md          # 중립 종합 리포트
```

---

## 참조 파일

- [워크플로우 상세](workflow.md)
- [출력 형식](output-format.md)

### Collectors

| Agent | 파일 |
|-------|------|
| 재무 분석가 | `agents/collectors/financial.md` |
| 비즈니스 모델 | `agents/collectors/business.md` |
| 경쟁 우위 | `agents/collectors/moat.md` |
| 매크로 분석 | `agents/collectors/macro.md` |

### Interpreters

| Interpreter | 파일 | 핵심 질문 |
|-------------|------|----------|
| 세상학개론 | `agents/interpreters/stocks/sesang.md` | "시대의 병목을 해결하는가?" |
| Cathie Wood | `agents/interpreters/stocks/cathie_wood.md` | "5년 후 세상을 바꿀 기술인가?" |
| Michael Burry | `agents/interpreters/stocks/michael_burry.md` | "이게 버블 아닌가?" |
| Terry Smith | `agents/interpreters/stocks/terry_smith.md` | "10년 보유할 기업인가?" |
| Howard Marks | `agents/interpreters/stocks/howard_marks.md` | "지금 사이클 어디인가?" |
| Druckenmiller | `agents/interpreters/stocks/druckenmiller.md` | "지금 진입 시점이 맞는가?" |
| Bill Ackman | `agents/interpreters/stocks/bill_ackman.md` | "가치를 끌어올릴 촉매가 있는가?" |

### Synthesizers

| Agent | 파일 |
|-------|------|
| 리포트 통합 | `agents/synthesizers/report_merger.md` |
| 투표 집계 | `agents/synthesizers/vote_aggregator.md` |

---

## onboarding과의 차이점

| 구분 | deep_dive | onboarding |
|------|-----------|------------|
| 목적 | 투자 판단 | 기업 이해 |
| 출력 | 팩트시트 + Interpreter | 서술형 Article |
| 대상 | 이미 아는 기업 | 처음 접하는 기업 |
| Interpreter | 7개 해석 | 없음 (중립) |
| 용어집 | 없음 | 포함 |

---

## 체크리스트

실행 전:
- [ ] 티커가 정확한가?
- [ ] 출력 디렉토리 날짜 확인 (YYYY-MM-DD)

실행 중:
- [ ] 1단계: 4개 Collector를 병렬 호출했는가?
- [ ] 2단계: 통합 완료 후 3단계 진행하는가?
- [ ] 3단계: 7개 Interpreter를 병렬 호출했는가?

실행 후:
- [ ] 7_final.md에 투표 집계가 있는가?
- [ ] 컨센서스와 논쟁점이 정리되었는가?
