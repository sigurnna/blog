# .claude 디렉토리 구조

이 디렉토리는 AI 투자 분석 멀티 에이전트 시스템의 설정 파일들을 포함합니다.

## 디렉토리 구조

```
.claude/
├── README.md                 # 이 파일
├── settings.json             # Claude Code 설정 (hooks 등)
├── settings.local.json       # 로컬 설정 (gitignore)
├── investor_profile.md       # 투자자 성향 프로필
├── portfolios.md             # 보유 자산 (gitignore)
│
├── agents/                   # Task 도구로 실행되는 Subagent
│   ├── collectors/           # 팩트 수집 에이전트 (8개)
│   ├── interpreters/         # Persona 내장 해석 에이전트
│   │   ├── stocks/           # 주식 투자 Interpreter (7개)
│   │   └── crypto/           # 암호화폐 Interpreter (1개)
│   └── synthesizers/         # 통합/집계 에이전트 (3개)
│
├── skills/                   # Skills (프로그레시브 디스클로저)
│   ├── deep_dive/            # 심층 분석 (Collector → Interpreter → 종합)
│   ├── onboarding/           # 기업 완전 정복 가이드
│   ├── coach/                # 세상학개론 코치
│   └── discover_gems/        # X(트위터) 기반 종목 발굴
│
└── hooks/                    # Claude Code hooks 스크립트
```

---

## agents/

**역할**: Task 도구를 통해 별도 컨텍스트에서 실행되는 Subagent 정의

### collectors/ (팩트 수집)

팩트와 데이터를 수집하는 에이전트. 해석 없이 객관적 정보만 수집.

| 파일 | 역할 | 사용 도구 |
|------|------|----------|
| `financial.md` | 재무 데이터 수집 (Lynch/Buffett/Fisher/Munger 지표) | WebSearch, WebFetch |
| `business.md` | 비즈니스 모델 분석 (Fisher 15포인트, Munger 단위경제학) | WebSearch, WebFetch |
| `moat.md` | 경쟁 우위/해자 분석 (Buffett/Munger 해자 프레임워크) | WebSearch, WebFetch |
| `macro.md` | 산업/거시경제 환경 분석 | WebSearch, WebFetch |
| `primary_source.md` | SEC 10-K/10-Q, Earnings Call 등 1차 자료 심층 조사 | WebSearch, WebFetch |
| `management.md` | 경영진 트랙레코드, 인터뷰, 내부자 거래 분석 | WebSearch, WebFetch |
| `narrative.md` | 시대적 맥락, 숨겨진 신호, 유동성 수혜 구조 조사 | WebSearch, WebFetch |

### interpreters/ (Persona 내장 해석)

각 투자자 관점을 내장한 해석 에이전트. Persona 파일 별도 로드 없이 자체적으로 관점 보유.

#### interpreters/stocks/

| 파일 | Persona | 관점 | 핵심 질문 |
|------|---------|------|----------|
| `sesang.md` | 세상학개론 | 내러티브 + 유동성 | "시대의 병목을 해결하는가?" |
| `cathie_wood.md` | Cathie Wood | 파괴적 혁신 | "5년 후 세상을 바꿀 기술인가?" |
| `michael_burry.md` | Michael Burry | 역발상 + Deep Value | "이게 버블 아닌가?" |
| `terry_smith.md` | Terry Smith | 품질 복리 | "10년 보유할 기업인가?" |
| `howard_marks.md` | Howard Marks | 사이클 + 리스크 | "지금 사이클 어디인가?" |
| `druckenmiller.md` | Druckenmiller | 매크로 + 타이밍 | "지금 진입 시점이 맞는가?" |
| `bill_ackman.md` | Bill Ackman | 행동주의 + 집중 | "가치를 끌어올릴 촉매가 있는가?" |

#### interpreters/crypto/

| 파일 | Persona | 관점 |
|------|---------|------|
| `oh_taemin.md` | 오태민 | 비트코인 화폐 철학 + 달러 지정학 |

### synthesizers/ (통합/집계)

여러 결과물을 통합하거나 집계하는 에이전트.

| 파일 | 역할 | 사용 도구 |
|------|------|----------|
| `report_merger.md` | 4개 팩트시트를 통합 팩트시트로 병합 | Read, Write |
| `vote_aggregator.md` | 7개 Interpreter 결과를 중립적으로 집계 | Read, Write |
| `onboarding_writer.md` | 10-30분 분량 서술형 Article 작성 | Read, Write |

---

## skills/

**역할**: 프로그레시브 디스클로저 방식의 Skill 정의

SKILL.md를 진입점으로 하고, 필요에 따라 추가 파일을 참조하여 컨텍스트를 절약합니다.

### deep_dive/ (심층 분석)

```
skills/deep_dive/
├── SKILL.md              # 진입점 (~100줄)
├── workflow.md           # 워크플로우 상세
└── output-format.md      # 출력 형식
```

| 커맨드 | 설명 |
|--------|------|
| `/deep-dive [티커]` | 4개 Collector → 통합 → 7개 Interpreter → 중립 종합 |

### onboarding/ (기업 완전 정복 가이드)

```
skills/onboarding/
├── SKILL.md              # 진입점 (~100줄)
├── workflow.md           # 워크플로우 상세
├── search-strategy.md    # 검색 전략 (공통)
└── prompts/              # Agent 프롬프트 템플릿
```

| 커맨드 | 설명 |
|--------|------|
| `/onboarding [티커]` | 처음 접하는 기업의 완전 정복 가이드 (서술형 Article) |

### coach/ (세상학개론 코치)

```
skills/coach/
├── SKILL.md              # 진입점 (~100줄)
├── flow.md               # 코치 플로우 상세
├── questions.md          # 질문 가이드 (단계별)
└── output-format.md      # Thesis 출력 형식
```

| 커맨드 | 설명 |
|--------|------|
| `/coach [티커]` | 소크라테스식 질문으로 투자 thesis 정리 유도 |

### discover_gems/ (X 기반 종목 발굴)

```
skills/discover_gems/
└── SKILL.md              # 진입점 (단일 파일)
```

| 커맨드 | 설명 |
|--------|------|
| `/discover-gems` | X(트위터)에서 노이즈 제거 후 10배 잠재력 종목 발굴 |

---

## hooks/

**역할**: Claude Code의 도구 실행 전후에 자동으로 실행되는 스크립트

| 파일 | 트리거 | 설명 |
|------|--------|------|
| `readme-update-check.sh` | PostToolUse (Edit/Write) | `.claude` 디렉토리 파일 변경 시 README 업데이트 알림 |

---

## docs/frameworks/

**역할**: 정량적 투자 기준 참조 문서 (Agent가 아님)

| 파일 | 투자자 | 핵심 지표 |
|------|--------|----------|
| `peter_lynch.md` | Peter Lynch | PEG < 1.0, 부채 < 80%, ROE ≥ 15% |
| `warren_buffett.md` | Warren Buffett | ROE 지속 ≥ 15%, Owner Earnings, 해자 |
| `philip_fisher.md` | Philip Fisher | 15포인트 체크리스트, R&D 효율성, 경영진 깊이 |
| `charlie_munger.md` | Charlie Munger | ROIC > 15%, 4가지 필터, 역발상 사고 |

---

## 워크플로우 흐름도

### Deep Dive

```
[1단계: 팩트 수집] - 4개 Collector 병렬
    ├─ collectors/financial
    ├─ collectors/business
    ├─ collectors/moat
    └─ collectors/macro
              │
[2단계: 통합]
    └─ synthesizers/report_merger
              │
[3단계: 해석] - 7개 Interpreter 병렬
    ├─ interpreters/stocks/sesang
    ├─ interpreters/stocks/cathie_wood
    ├─ interpreters/stocks/michael_burry
    ├─ interpreters/stocks/terry_smith
    ├─ interpreters/stocks/howard_marks
    ├─ interpreters/stocks/druckenmiller
    └─ interpreters/stocks/bill_ackman
              │
[4단계: 종합]
    └─ synthesizers/vote_aggregator
```

### Thesis Building

```
/coach [티커]        →  소크라테스식 질문으로 thesis 정리
```

---

## 출력 디렉토리

분석 결과물은 `reports/` 디렉토리에 저장됩니다:

```
reports/
├── [티커]/
│   ├── thesis.md              # /coach 결과
│   ├── YYYY-MM-DD/            # /deep-dive 결과
│   └── onboarding/            # /onboarding 결과
```
