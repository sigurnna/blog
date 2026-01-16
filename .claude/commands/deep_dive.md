---
name: deep-dive
description: 특정 종목에 대한 심층 분석 워크플로우. 4개 Agent로 팩트 수집 후, 6개 Persona의 다각도 해석을 거쳐 중립적 종합 리포트를 생성합니다.
args: ticker
---

# Deep Dive 분석

> 특정 종목에 대한 심층 분석 워크플로우
> 분석 대상: **$ARGUMENTS**

## ⚠️ 컨텍스트 관리 원칙

**반드시 Task 도구를 사용하여 서브에이전트로 실행할 것!**

- 각 Agent/Persona는 **Task 도구**로 실행 (메인 컨텍스트 절약)
- 서브에이전트 결과는 **파일로 저장** 후 메인에는 완료 여부만 반환
- 병렬 실행 가능한 단계는 **단일 메시지에 여러 Task 호출**로 동시 실행
- WebSearch/WebFetch는 **서브에이전트 내에서만** 실행

## 아키텍처

```
[1단계: 팩트 수집] - 4개 Agent 병렬 실행
    ├─ financial_analyst   → 재무 팩트시트
    ├─ business_model      → 비즈니스 모델 팩트시트
    ├─ competitive_moat    → 경쟁 우위 팩트시트
    └─ macro_analyst       → 매크로/산업 팩트시트
              │
              ▼
[2단계: 팩트 통합] - 별도 Agent
    └─ report_synthesizer  → 통합 팩트시트
              │
              ▼
[3단계: 다각도 해석] - 7개 Persona 병렬 실행
    ├─ 세상학개론 (sesang)           → 내러티브 + 유동성
    ├─ Cathie Wood (wood)            → 파괴적 혁신
    ├─ Michael Burry (burry)         → 역발상 + 리스크
    ├─ Terry Smith (smith)           → 품질 복리
    ├─ Howard Marks (marks)          → 사이클 + 리스크
    ├─ Druckenmiller (druckenmiller) → 매크로 타이밍
    └─ Bill Ackman (ackman)          → 행동주의 + 촉매
              │
              ▼
[4단계: 중립 종합] - Persona 없이 순수 집계
    └─ 7개 분석 결과를 중립적으로 집계
    └─ 투표 결과, 컨센서스, 논쟁점만 정리
```

---

## 단계별 상세

### 1단계: 팩트 수집 (병렬)

**목적**: 객관적 데이터 수집

| Agent | subagent_type | 출력 파일 |
|-------|---------------|----------|
| 재무 분석가 | `financial-analyst` | `1_financial.md` |
| 비즈니스 모델 | `business-model-analyst` | `2_business.md` |
| 경쟁 우위 | `competitive-moat-analyst` | `3_moat.md` |
| 매크로 분석 | `macro-analyst` | `4_macro.md` |

**실행 방법**: 단일 메시지에서 4개의 Task 도구를 **병렬 호출**

```
Task(subagent_type="financial-analyst", prompt="[티커] 재무 분석. 결과를 reports/[티커]/[날짜]/1_financial.md에 저장")
Task(subagent_type="business-model-analyst", prompt="[티커] 비즈니스 모델 분석. 결과를 reports/[티커]/[날짜]/2_business.md에 저장")
Task(subagent_type="competitive-moat-analyst", prompt="[티커] 경쟁 우위 분석. 결과를 reports/[티커]/[날짜]/3_moat.md에 저장")
Task(subagent_type="macro-analyst", prompt="[티커] 매크로 분석. 결과를 reports/[티커]/[날짜]/4_macro.md에 저장")
```

**컨텍스트**: 각 Agent는 **별도 프로세스**에서 독립 실행 → 메인 컨텍스트 절약

**출력**: 4개의 개별 팩트시트 (파일로 저장됨)

---

### 2단계: 팩트 통합

**목적**: 4개 팩트시트를 하나로 병합

| Agent | subagent_type | 출력 파일 |
|-------|---------------|----------|
| 리포트 통합가 | `report-synthesizer` | `5_synthesized.md` |

**실행 방법**: 1단계 완료 후 Task 도구 호출

```
Task(subagent_type="report-synthesizer", prompt="reports/[티커]/[날짜]/의 1~4번 팩트시트를 통합. 결과를 5_synthesized.md에 저장")
```

**입력**: 1단계의 4개 팩트시트 (파일에서 읽음)

**컨텍스트**: 서브에이전트가 파일을 직접 읽어서 처리 → 메인 컨텍스트에 팩트시트 내용 안 쌓임

**출력**: 통합 팩트시트 + 프레임워크 충족률 집계 (파일로 저장됨)

---

### 3단계: 다각도 해석 (병렬)

**목적**: 7개 Persona 관점으로 각각 독립적 해석

| Persona | persona_id | 출력 파일 | 핵심 질문 |
|---------|------------|----------|----------|
| 세상학개론 | `sesang` | `6_sesang.md` | "시대의 병목을 해결하는가?" |
| Cathie Wood | `wood` | `6_wood.md` | "5년 후 세상을 바꿀 기술인가?" |
| Michael Burry | `burry` | `6_burry.md` | "이게 버블 아닌가?" |
| Terry Smith | `smith` | `6_smith.md` | "10년 보유할 기업인가?" |
| Howard Marks | `marks` | `6_marks.md` | "지금 사이클 어디인가?" |
| Druckenmiller | `druckenmiller` | `6_druckenmiller.md` | "지금 진입 시점이 맞는가?" |
| Bill Ackman | `ackman` | `6_ackman.md` | "가치를 끌어올릴 촉매가 있는가?" |

**실행 방법**: 단일 메시지에서 7개의 Task 도구를 **병렬 호출**

```
Task(subagent_type="investment-interpreter", prompt="[티커] 해석. Persona: sesang. 통합 팩트시트: reports/[티커]/[날짜]/5_synthesized.md. 결과를 6_sesang.md에 저장")
Task(subagent_type="investment-interpreter", prompt="[티커] 해석. Persona: wood. 통합 팩트시트: reports/[티커]/[날짜]/5_synthesized.md. 결과를 6_wood.md에 저장")
Task(subagent_type="investment-interpreter", prompt="[티커] 해석. Persona: burry. 통합 팩트시트: reports/[티커]/[날짜]/5_synthesized.md. 결과를 6_burry.md에 저장")
Task(subagent_type="investment-interpreter", prompt="[티커] 해석. Persona: smith. 통합 팩트시트: reports/[티커]/[날짜]/5_synthesized.md. 결과를 6_smith.md에 저장")
Task(subagent_type="investment-interpreter", prompt="[티커] 해석. Persona: marks. 통합 팩트시트: reports/[티커]/[날짜]/5_synthesized.md. 결과를 6_marks.md에 저장")
Task(subagent_type="investment-interpreter", prompt="[티커] 해석. Persona: druckenmiller. 통합 팩트시트: reports/[티커]/[날짜]/5_synthesized.md. 결과를 6_druckenmiller.md에 저장")
Task(subagent_type="investment-interpreter", prompt="[티커] 해석. Persona: ackman. 통합 팩트시트: reports/[티커]/[날짜]/5_synthesized.md. 결과를 6_ackman.md에 저장")
```

**입력**:
- 2단계의 통합 팩트시트 (파일에서 읽음)
- 각 Persona 파일 (서브에이전트가 직접 참조)
- `investor_profile.md` (서브에이전트가 직접 참조)

**컨텍스트**: 각 Persona는 **별도 프로세스**에서 독립 실행 → 메인 컨텍스트에 해석 내용 안 쌓임

**출력**: 7개의 개별 해석 리포트 (파일로 저장됨)

---

### 4단계: 중립 종합

**목적**: 7개 Persona 분석을 **중립적으로 집계**

**출력 파일**: `7_final.md`

**실행 방법**: 메인에서 직접 처리 (6개 파일 읽어서 집계만 수행)

```
1. 7개의 6_*.md 파일을 Read 도구로 읽음
2. 아래 출력 형식에 따라 7_final.md 작성
3. 해석/판단 없이 순수 집계만 수행
```

**핵심 원칙**:
- ⚠️ **Persona 주입 금지**: 어떤 투자자 관점도 사용하지 않음
- ⚠️ **해석/판단 금지**: 분석가 개인 의견 추가하지 않음
- ✅ **순수 집계만**: 각 Persona의 결론을 있는 그대로 정리
- ✅ **투표 결과만**: 매수/관망/패스 투표 집계
- ✅ **논쟁점 나열만**: 의견이 갈리는 부분 객관적 나열

**입력**: 3단계의 6개 해석 리포트 (파일에서 읽음)

**출력 형식**:

```markdown
# [기업명] 종합 분석 결과

> 분석일: YYYY-MM-DD
> 집계 방식: 7개 Persona 중립 집계 (해석/판단 없음)

---

## 투표 결과

| Persona | 판단 | 확신도 | 10배 가능성 |
|---------|------|--------|------------|
| 세상학개론 | 매수/관망/패스 | ★★★★★ | 높음/중간/낮음 |
| Cathie Wood | 매수/관망/패스 | ★★★★★ | 높음/중간/낮음 |
| Michael Burry | 매수/관망/패스 | ★★★★★ | 높음/중간/낮음 |
| Terry Smith | 매수/관망/패스 | ★★★★★ | 높음/중간/낮음 |
| Howard Marks | 매수/관망/패스 | ★★★★★ | 높음/중간/낮음 |
| Druckenmiller | 매수/관망/패스 | ★★★★★ | 높음/중간/낮음 |
| Bill Ackman | 매수/관망/패스 | ★★★★★ | 높음/중간/낮음 |

### 집계

| 판단 | 인원 |
|------|------|
| 매수 | X명 |
| 관망 | X명 |
| 패스 | X명 |

---

## Persona별 핵심 논리 (원문 그대로)

### 세상학개론
- **판단**: 매수/관망/패스
- **핵심 논리**: (해당 리포트에서 직접 인용)
- **주요 강점**: (해당 리포트에서 직접 인용)
- **주요 우려**: (해당 리포트에서 직접 인용)

### Cathie Wood
- **판단**: 매수/관망/패스
- **핵심 논리**: (해당 리포트에서 직접 인용)
- **주요 강점**: (해당 리포트에서 직접 인용)
- **주요 우려**: (해당 리포트에서 직접 인용)

### Michael Burry
- **판단**: 매수/관망/패스
- **핵심 논리**: (해당 리포트에서 직접 인용)
- **주요 강점**: (해당 리포트에서 직접 인용)
- **주요 우려**: (해당 리포트에서 직접 인용)

### Terry Smith
- **판단**: 매수/관망/패스
- **핵심 논리**: (해당 리포트에서 직접 인용)
- **주요 강점**: (해당 리포트에서 직접 인용)
- **주요 우려**: (해당 리포트에서 직접 인용)

### Howard Marks
- **판단**: 매수/관망/패스
- **핵심 논리**: (해당 리포트에서 직접 인용)
- **주요 강점**: (해당 리포트에서 직접 인용)
- **주요 우려**: (해당 리포트에서 직접 인용)

### Druckenmiller
- **판단**: 매수/관망/패스
- **핵심 논리**: (해당 리포트에서 직접 인용)
- **주요 강점**: (해당 리포트에서 직접 인용)
- **주요 우려**: (해당 리포트에서 직접 인용)

### Bill Ackman
- **판단**: 매수/관망/패스
- **핵심 논리**: (해당 리포트에서 직접 인용)
- **주요 강점**: (해당 리포트에서 직접 인용)
- **주요 우려**: (해당 리포트에서 직접 인용)

---

## 컨센서스 (다수 동의 항목)

### 강점 (2명 이상 동의)
| 항목 | 동의한 Persona |
|------|---------------|
| (강점 1) | A, B, C |
| (강점 2) | A, D |

### 우려 (2명 이상 동의)
| 항목 | 동의한 Persona |
|------|---------------|
| (우려 1) | A, B, C |
| (우려 2) | B, E, F |

---

## 논쟁점 (의견 분열)

Persona 간 의견이 갈리는 핵심 이슈:

| 논쟁점 | 긍정 측 | 부정 측 |
|--------|---------|---------|
| (예: 밸류에이션) | 세상학개론, Wood | Burry, Smith |
| (예: 매크로 타이밍) | Druckenmiller, Ackman | Burry |

---

## 모니터링 포인트 (Persona별 제안 종합)

| 항목 | 제안한 Persona |
|------|---------------|
| (모니터링 1) | A, B |
| (모니터링 2) | C, D, E |
| (모니터링 3) | F |

---

> ⚠️ 이 리포트는 6개 Persona의 분석 결과를 **중립적으로 집계**한 것입니다.
> 최종 투자 판단은 투자자 본인이 내려야 합니다.
> 개별 Persona 분석은 `6_[persona].md` 파일을 참조하세요.
```

---

## 사용 방법

### 기본 사용 (전체 워크플로우)

```
사용자: "IREN deep dive 해줘"

실행 순서:
1. financial_analyst, business_model, competitive_moat, macro_analyst 병렬 실행
2. report_synthesizer로 통합
3. 7개 Persona 병렬 해석
4. 중립 집계로 종합 리포트 생성
```

### 특정 Persona만 실행

```
사용자: "IREN을 Burry 관점으로만 분석해줘"

→ 3단계에서 해당 Persona만 실행
→ 4단계 스킵
```

### 기존 팩트시트 재사용

```
사용자: "아까 분석한 IREN 종합 리포트 다시 만들어줘"

→ 1, 2단계 스킵
→ 기존 통합 팩트시트로 3, 4단계 실행
```

---

## 파일 참조

### Frameworks (근간 프레임워크)
- `personas/stocks/frameworks/peter_lynch.md`
- `personas/stocks/frameworks/warren_buffett.md`
- `personas/stocks/frameworks/philip_fisher.md`
- `personas/stocks/frameworks/charlie_munger.md`

### Personas (해석 관점)

| 유형 | Persona | 파일 |
|------|---------|------|
| 공격 | 세상학개론 | `personas/stocks/sesang.md` |
| 공격 | Cathie Wood | `personas/stocks/cathie_wood.md` |
| 방어 | Michael Burry | `personas/stocks/michael_burry.md` |
| 방어 | Terry Smith | `personas/stocks/terry_smith.md` |
| 방어 | Howard Marks | `personas/stocks/howard_marks.md` |
| 매크로 | Druckenmiller | `personas/stocks/stanley_druckenmiller.md` |
| 촉매 | Bill Ackman | `personas/stocks/bill_ackman.md` |

### 투자자 프로필
- `investor_profile.md` - 10배 성장주, 집중투자

---

## 출력물 저장

각 단계의 결과물은 `reports/[티커]/[날짜]/`에 저장:

```
reports/
└── [티커]/
    └── YYYY-MM-DD/
        ├── 1_financial.md        # 1단계: 재무 팩트시트
        ├── 2_business.md         # 1단계: 비즈니스 모델 팩트시트
        ├── 3_moat.md             # 1단계: 경쟁 우위 팩트시트
        ├── 4_macro.md            # 1단계: 매크로 팩트시트
        ├── 5_synthesized.md      # 2단계: 통합 팩트시트
        ├── 6_sesang.md           # 3단계: 세상학개론 해석
        ├── 6_wood.md             # 3단계: Cathie Wood 해석
        ├── 6_burry.md            # 3단계: Burry 해석
        ├── 6_smith.md            # 3단계: Smith 해석
        ├── 6_marks.md            # 3단계: Howard Marks 해석
        ├── 6_druckenmiller.md    # 3단계: Druckenmiller 해석
        ├── 6_ackman.md           # 3단계: Ackman 해석
        └── 7_final.md            # 4단계: 중립 종합 리포트
```

### 저장 규칙

| 단계 | 파일명 | 내용 |
|------|--------|------|
| 1단계 | `1_financial.md` | 재무 분석 팩트시트 |
| 1단계 | `2_business.md` | 비즈니스 모델 팩트시트 |
| 1단계 | `3_moat.md` | 경쟁 우위 팩트시트 |
| 1단계 | `4_macro.md` | 매크로/산업 팩트시트 |
| 2단계 | `5_synthesized.md` | 통합 팩트시트 |
| 3단계 | `6_[persona].md` | 개별 Persona 해석 (7개) |
| 4단계 | `7_final.md` | 중립 종합 리포트 |

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
        │  - 투표 집계                        │
        │  - 컨센서스 나열                    │
        │  - 논쟁점 나열                      │
        │  - 해석/판단 없음                   │
        └─────────────────────────────────────┘
```

이 구조로 다음을 확보:
- **7개 독립적 관점**: 각 Persona가 자신의 철학대로 해석
- **중립적 종합**: 4단계에서 어떤 편향도 없이 집계만 수행
- **투자자 자율성**: 최종 판단은 투자자 본인이 수행
