# Workflow: Deep Dive 분석

> 특정 종목에 대한 심층 분석 워크플로우

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
[3단계: 투자 해석] - 별도 Agent + Persona
    └─ investment_interpreter + Persona
              │
         ┌────┴────┐
         ▼         ▼
    세상학개론    아그리파
      리포트      리포트
```

## 단계별 상세

### 1단계: 팩트 수집 (병렬)

**목적**: 객관적 데이터 수집

| Agent | 파일 | 참조 프레임워크 |
|-------|------|----------------|
| 재무 분석가 | `agents/financial_analyst.md` | Lynch, Buffett, Fisher, Munger |
| 비즈니스 모델 | `agents/business_model.md` | Fisher 15포인트, Munger |
| 경쟁 우위 | `agents/competitive_moat.md` | Buffett/Munger 해자 |
| 매크로 분석 | `agents/macro_analyst.md` | Lynch 분류, Munger 리스크 |

**컨텍스트**: 각 Agent는 독립적으로 실행, 서로의 결과를 모름

**출력**: 4개의 개별 팩트시트

---

### 2단계: 팩트 통합

**목적**: 4개 팩트시트를 하나로 병합

| Agent | 파일 |
|-------|------|
| 리포트 통합가 | `agents/report_synthesizer.md` |

**입력**: 1단계의 4개 팩트시트

**컨텍스트**: 새로운 컨텍스트, 팩트시트만 전달받음

**출력**: 통합 팩트시트 + 프레임워크 충족률 집계

---

### 3단계: 투자 해석

**목적**: Persona 관점으로 해석하여 투자 판단

| Agent | 파일 |
|-------|------|
| 투자 해석가 | `agents/investment_interpreter.md` |

**입력**:
- 2단계의 통합 팩트시트
- Persona 파일 (선택)
- `investor_profile.md` (필수)

**컨텍스트**: 새로운 컨텍스트, 통합 팩트시트 + Persona만 전달

**출력**: 투자 분석 리포트

---

## 사용 방법

### 기본 사용

```
사용자: "IREN deep dive 해줘"

실행 순서:
1. financial_analyst, business_model, competitive_moat, macro_analyst 병렬 실행
2. report_synthesizer로 통합
3. investment_interpreter + 기본 Persona로 해석
4. 최종 리포트 출력
```

### Persona 지정

```
사용자: "IREN을 세상학개론 관점으로 분석해줘"

→ 3단계에서 personas/sesang.md 적용
```

### 다중 Persona 비교

```
사용자: "IREN을 세상학개론, 아그리파 두 관점으로 분석해줘"

→ 3단계를 2번 실행 (각각 다른 Persona)
→ 2개의 리포트 출력
```

### 기존 팩트시트 재사용

```
사용자: "아까 분석한 IREN을 아그리파 관점으로도 봐줘"

→ 1, 2단계 스킵
→ 기존 통합 팩트시트 + 다른 Persona로 3단계만 실행
```

---

## 파일 참조

### Frameworks (투자자 프레임워크)
- `frameworks/peter_lynch.md`
- `frameworks/warren_buffett.md`
- `frameworks/philip_fisher.md`
- `frameworks/charlie_munger.md`

### Personas (해석 관점)
- `personas/sesang.md` - 내러티브 + 유동성
- `personas/agrippa_investments.md` - 인프라 자산 중심

### 투자자 프로필
- `investor_profile.md` - 10배 성장주, 집중투자

---

## 출력물 저장

각 단계의 결과물은 `data/processed/[티커]/[날짜]/`에 저장:

```
data/processed/
└── [티커]/
    └── YYYY-MM-DD/
        ├── 1_financial.md      # Agent 1: 재무 팩트시트
        ├── 2_business.md       # Agent 2: 비즈니스 모델 팩트시트
        ├── 3_moat.md           # Agent 3: 경쟁 우위 팩트시트
        ├── 4_macro.md          # Agent 4: 매크로 팩트시트
        ├── 5_synthesized.md    # 통합 팩트시트
        └── 6_[persona].md      # 최종 해석 리포트
```

예시:
```
data/processed/IREN/2026-01-10/
├── 1_financial.md
├── 2_business.md
├── 3_moat.md
├── 4_macro.md
├── 5_synthesized.md
├── 6_sesang.md
└── 6_agrippa.md
```

### 저장 규칙

| 단계 | 파일명 | 내용 |
|------|--------|------|
| 1단계 | `1_financial.md` | 재무 분석 팩트시트 |
| 1단계 | `2_business.md` | 비즈니스 모델 팩트시트 |
| 1단계 | `3_moat.md` | 경쟁 우위 팩트시트 |
| 1단계 | `4_macro.md` | 매크로/산업 팩트시트 |
| 2단계 | `5_synthesized.md` | 통합 팩트시트 |
| 3단계 | `6_[persona].md` | 최종 해석 리포트 |

### 재사용

같은 날짜에 다른 Persona로 재분석 시:
- 1~5번 파일 재사용
- 6번만 새로 생성 (예: `6_agrippa.md` 추가)

블로그 포스팅(`_posts/`)은 사용자가 직접 작성.
