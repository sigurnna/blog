# Deep Dive 워크플로우 상세

## 1단계: 팩트 수집 (병렬)

**목적**: 객관적 데이터 수집 (해석 없이)

### Agent 목록

| Agent | subagent_type | 출력 파일 |
|-------|---------------|----------|
| 재무 분석가 | `financial-analyst` | `1_financial.md` |
| 비즈니스 모델 | `business-model-analyst` | `2_business.md` |
| 경쟁 우위 | `competitive-moat-analyst` | `3_moat.md` |
| 매크로 분석 | `macro-analyst` | `4_macro.md` |

### 실행 방법

**단일 메시지에서 4개의 Task 도구를 병렬 호출**:

```
Task(subagent_type="financial-analyst",
     prompt="[티커] 재무 분석. 결과를 reports/[티커]/[날짜]/1_financial.md에 저장")

Task(subagent_type="business-model-analyst",
     prompt="[티커] 비즈니스 모델 분석. 결과를 reports/[티커]/[날짜]/2_business.md에 저장")

Task(subagent_type="competitive-moat-analyst",
     prompt="[티커] 경쟁 우위 분석. 결과를 reports/[티커]/[날짜]/3_moat.md에 저장")

Task(subagent_type="macro-analyst",
     prompt="[티커] 매크로 분석. 결과를 reports/[티커]/[날짜]/4_macro.md에 저장")
```

---

## 2단계: 팩트 통합

**목적**: 4개 팩트시트를 하나로 병합

### Agent

| Agent | subagent_type | 출력 파일 |
|-------|---------------|----------|
| 리포트 통합 | `report-synthesizer` | `5_synthesized.md` |

### 실행 방법

**1단계 완료 후** Task 도구 호출:

```
Task(subagent_type="report-synthesizer",
     prompt="reports/[티커]/[날짜]/의 1~4번 팩트시트를 통합. 결과를 5_synthesized.md에 저장")
```

---

## 3단계: 다각도 해석 (병렬)

**목적**: 7개 Interpreter 관점으로 독립적 해석

### Interpreter 목록

| Interpreter | subagent_type | 출력 파일 |
|-------------|---------------|----------|
| 세상학개론 | `sesang-interpreter` | `6_sesang.md` |
| Cathie Wood | `cathie-wood-interpreter` | `6_cathie_wood.md` |
| Michael Burry | `michael-burry-interpreter` | `6_michael_burry.md` |
| Terry Smith | `terry-smith-interpreter` | `6_terry_smith.md` |
| Howard Marks | `howard-marks-interpreter` | `6_howard_marks.md` |
| Druckenmiller | `druckenmiller-interpreter` | `6_druckenmiller.md` |
| Bill Ackman | `bill-ackman-interpreter` | `6_bill_ackman.md` |

### 실행 방법

**단일 메시지에서 7개의 Task 도구를 병렬 호출**:

```
Task(subagent_type="sesang-interpreter",
     prompt="[티커] 해석. 통합 팩트시트: reports/[티커]/[날짜]/5_synthesized.md. 결과를 6_sesang.md에 저장")

Task(subagent_type="cathie-wood-interpreter",
     prompt="[티커] 해석. 통합 팩트시트: reports/[티커]/[날짜]/5_synthesized.md. 결과를 6_cathie_wood.md에 저장")

Task(subagent_type="michael-burry-interpreter",
     prompt="[티커] 해석. 통합 팩트시트: reports/[티커]/[날짜]/5_synthesized.md. 결과를 6_michael_burry.md에 저장")

Task(subagent_type="terry-smith-interpreter",
     prompt="[티커] 해석. 통합 팩트시트: reports/[티커]/[날짜]/5_synthesized.md. 결과를 6_terry_smith.md에 저장")

Task(subagent_type="howard-marks-interpreter",
     prompt="[티커] 해석. 통합 팩트시트: reports/[티커]/[날짜]/5_synthesized.md. 결과를 6_howard_marks.md에 저장")

Task(subagent_type="druckenmiller-interpreter",
     prompt="[티커] 해석. 통합 팩트시트: reports/[티커]/[날짜]/5_synthesized.md. 결과를 6_druckenmiller.md에 저장")

Task(subagent_type="bill-ackman-interpreter",
     prompt="[티커] 해석. 통합 팩트시트: reports/[티커]/[날짜]/5_synthesized.md. 결과를 6_bill_ackman.md에 저장")
```

---

## 4단계: 중립 종합

**목적**: 7개 Interpreter 분석을 중립적으로 집계

### Agent

| Agent | subagent_type | 출력 파일 |
|-------|---------------|----------|
| 투표 집계 | `vote-aggregator` | `7_final.md` |

### 실행 방법

**3단계 완료 후** Task 도구 호출:

```
Task(subagent_type="vote-aggregator",
     prompt="reports/[티커]/[날짜]/의 7개 해석 리포트(6_*.md)를 집계. 결과를 7_final.md에 저장")
```

### 핵심 원칙

- **Persona 주입 금지**: 어떤 투자자 관점도 사용하지 않음
- **해석/판단 금지**: 분석가 개인 의견 추가하지 않음
- **순수 집계만**: 각 Interpreter의 결론을 있는 그대로 정리
- **투표 결과만**: 매수/관망/패스 투표 집계
- **논쟁점 나열만**: 의견이 갈리는 부분 객관적 나열

---

## 변형 실행

### 특정 Interpreter만 실행

```
사용자: "IREN을 Burry 관점으로만 분석해줘"

→ 3단계에서 michael-burry-interpreter만 실행
→ 4단계 스킵
```

### 기존 팩트시트 재사용

```
사용자: "아까 분석한 IREN 종합 리포트 다시 만들어줘"

→ 1, 2단계 스킵
→ 기존 5_synthesized.md로 3, 4단계 실행
```

---

## 분석 균형

```
        ┌─────────────────────────────────────┐
        │           공격적 (Bull)              │
        │  ┌───────────┐   ┌───────────┐      │
        │  │ 세상학개론 │   │Cathie Wood│      │
        │  │(내러티브) │   │(파괴적혁신)│      │
        │  └───────────┘   └───────────┘      │
        └─────────────────────────────────────┘
                         │
        ┌────────────────┼────────────────┐
        │                ▼                │
        │  ┌───────────┐   ┌───────────┐  │
        │  │Druckenmiller│ │ Ackman    │  │
        │  │(매크로)    │   │(촉매)     │  │
        │  └───────────┘   └───────────┘  │
        │        균형/타이밍              │
        └─────────────────────────────────┘
                         │
        ┌────────────────┼────────────────┐
        │                ▼                │
        │  ┌─────────┐ ┌─────────┐ ┌─────────┐ │
        │  │ Burry   │ │ Smith   │ │ Marks   │ │
        │  │(역발상) │ │(품질)   │ │(사이클) │ │
        │  └─────────┘ └─────────┘ └─────────┘ │
        │           방어적 (Bear)              │
        └──────────────────────────────────────┘
                         │
                         ▼
        ┌─────────────────────────────────────┐
        │      4단계: 중립 종합 (Persona 없음)  │
        └─────────────────────────────────────┘
```
