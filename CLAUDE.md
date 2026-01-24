# AI 투자 분석가

이 프로젝트는 금융 및 투자 분석을 수행하는 멀티 에이전트 시스템입니다.

## 투자자 프로필

- **목표**: 3~5년 내 10배 이상 수익 (공격적)
- **전략**: 3~5개 핵심 종목 집중 투자
- **리스크 허용**: 50~70% 하락 감내 가능
- **분석 선호**: 펀더멘탈 심층 분석, 장기 관점

상세: `.claude/investor_profile.md`, `.claude/portfolios.md`

## 핵심 수칙

1. **환각 금지**: 주가/뉴스 지어내지 마라. 데이터 없으면 요청하라
2. **컨텍스트 분리**: 각 Agent는 독립 실행, 결과만 전달
3. **팩트와 해석 분리**: Collector는 팩트 수집, Interpreter만 해석
4. **존댓말 사용**: 사용자에게 항상 존댓말로 응대할 것. 반말 금지.

## 임시 작업 디렉토리 (.task)

**작업 디렉토리가 명시적으로 지정되지 않은 모든 작업**은 `.task/` 디렉토리에 저장합니다.

### 규칙

1. **위치**: 프로젝트 루트의 `.task/` 디렉토리 (gitignore됨)
2. **네이밍**: `YYYY-MM-DD_작업이름` 형식의 서브디렉토리 생성
3. **작업이름**: 영문 소문자, 언더스코어 사용 (예: `debate_cathie_wood`, `research_nvidia`)

### 제외 대상 (기존 경로 사용)

- `/deep-dive` → `reports/[티커]/YYYY-MM-DD/`
- `/onboarding` → `reports/[티커]/onboarding/`
- `/coach` → `reports/[티커]/thesis.md`

## 디렉토리 구조

```
.task/                            # 임시 작업 디렉토리 (gitignore)
└── YYYY-MM-DD_작업이름/          # 날짜+작업명 서브디렉토리

.claude/
├── investor_profile.md       # 투자자 성향
├── portfolios.md             # 보유 자산
│
├── agents/                   # Task 도구로 실행되는 Subagent
│   ├── collectors/           # 팩트 수집 에이전트 (8개)
│   │   ├── financial.md          # 재무 지표 수집
│   │   ├── business.md           # 비즈니스 모델 분석
│   │   ├── moat.md               # 경쟁 우위/해자 분석
│   │   ├── macro.md              # 매크로/산업 분석
│   │   ├── primary_source.md     # 1차 자료 심층 조사 (SEC, Earnings Call)
│   │   ├── management.md         # 경영진 프로파일링
│   │   └── narrative.md          # 내러티브/시대적 맥락
│   │
│   ├── interpreters/         # Persona 내장 해석 에이전트
│   │   ├── stocks/               # 주식 투자 (7개)
│   │   │   ├── sesang.md             # 세상학개론 (내러티브+유동성)
│   │   │   ├── cathie_wood.md        # Cathie Wood (파괴적 혁신)
│   │   │   ├── michael_burry.md      # Michael Burry (역발상+Deep Value)
│   │   │   ├── terry_smith.md        # Terry Smith (품질 복리)
│   │   │   ├── howard_marks.md       # Howard Marks (사이클+리스크)
│   │   │   ├── druckenmiller.md      # Druckenmiller (매크로+타이밍)
│   │   │   └── bill_ackman.md        # Bill Ackman (행동주의+집중)
│   │   └── crypto/               # 암호화폐 (1개)
│   │       └── oh_taemin.md          # 오태민 (비트코인 화폐철학+지정학)
│   │
│   └── synthesizers/         # 통합/집계 에이전트 (3개)
│       ├── report_merger.md      # 팩트시트 통합
│       ├── vote_aggregator.md    # Interpreter 투표 집계
│       └── onboarding_writer.md  # 서술형 Article 작성
│
├── skills/                   # Skills (프로그레시브 디스클로저)
│   ├── deep_dive/            # 심층 분석
│   │   ├── SKILL.md              # 진입점
│   │   ├── workflow.md           # 워크플로우 상세
│   │   └── output-format.md      # 출력 형식
│   │
│   ├── onboarding/           # 기업 완전 정복 가이드
│   │   ├── SKILL.md              # 진입점
│   │   ├── workflow.md           # 워크플로우 상세
│   │   ├── search-strategy.md    # 검색 전략
│   │   └── prompts/              # Agent 프롬프트 템플릿
│   │
│   ├── coach/                # 세상학개론 코치
│   │   ├── SKILL.md              # 진입점
│   │   ├── flow.md               # 코치 플로우 상세
│   │   ├── questions.md          # 질문 가이드
│   │   └── output-format.md      # Thesis 출력 형식
│   │
│   └── discover_gems/        # X 기반 종목 발굴
│       └── SKILL.md              # 진입점

docs/                             # 참조 문서
├── frameworks/                   # 정량적 투자 기준
│   ├── peter_lynch.md            # PEG, 성장률, GARP
│   ├── warren_buffett.md         # ROE, Owner Earnings, 해자
│   ├── philip_fisher.md          # 15포인트, 정성적 분석
│   └── charlie_munger.md         # ROIC, 멘탈모델, 역발상
└── financial_glossary.md         # 재무 용어집

reports/                          # 모든 분석 결과물 저장
└── [티커]/
    ├── thesis.md                 # 코치 모드 결과
    ├── YYYY-MM-DD/               # Deep Dive 결과
    │   ├── 1_financial.md        # 재무 팩트시트
    │   ├── 2_business.md         # 비즈니스 모델 팩트시트
    │   ├── 3_moat.md             # 경쟁 우위 팩트시트
    │   ├── 4_macro.md            # 매크로 팩트시트
    │   ├── 5_synthesized.md      # 통합 팩트시트
    │   ├── 6_[interpreter].md    # Interpreter별 해석 (7개)
    │   └── 7_final.md            # 중립 종합 리포트
    └── onboarding/               # 기업 완전 정복 가이드
```

## Deep Dive 워크플로우

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
[3단계: 다각도 해석] - 7개 Interpreter 병렬
    ├─ interpreters/stocks/sesang (공격/내러티브)
    ├─ interpreters/stocks/cathie_wood (공격/파괴적 혁신)
    ├─ interpreters/stocks/michael_burry (방어/역발상)
    ├─ interpreters/stocks/terry_smith (방어/품질)
    ├─ interpreters/stocks/howard_marks (방어/사이클)
    ├─ interpreters/stocks/druckenmiller (매크로/타이밍)
    └─ interpreters/stocks/bill_ackman (촉매/행동주의)
              │
[4단계: 중립 종합]
    └─ synthesizers/vote_aggregator
```

상세: `.claude/skills/deep_dive/SKILL.md`

## Onboarding 워크플로우 (기업 완전 정복)

```
/onboarding [티커]

[1단계: 조사] - 5개 Collector 병렬
    ├─ collectors/business (light) → 사업 개요
    ├─ collectors/macro (light) → 산업 개요
    ├─ collectors/primary_source → SEC 10-K, Earnings Call
    ├─ collectors/management → 경영진 트랙레코드
    └─ collectors/narrative → 시대적 맥락, 숨겨진 신호
              │
[2단계: Article 작성]
    └─ synthesizers/onboarding_writer → 10-30분 분량 서술형 Article
              │
[출력]
    └─ reports/[티커]/onboarding/article.md
```

상세: `.claude/skills/onboarding/SKILL.md`

## Thesis Building 워크플로우

```
/coach [티커]           # 세상학개론 코치와 thesis 정리
                        # - 빈 캔버스에서 시작
                        # - 소크라테스식 질문으로 사고 유도
                        # - "내 말"로 투자 논리 정리
```

상세: `.claude/skills/coach/SKILL.md`

## Interpreter 요약

| Interpreter | 관점 | 핵심 질문 |
|-------------|------|----------|
| sesang | 내러티브 + 유동성 | "시대의 병목을 해결하는가?" |
| cathie_wood | 파괴적 혁신 | "5년 후 세상을 바꿀 기술인가?" |
| michael_burry | 역발상 + Deep Value | "이게 버블 아닌가?" |
| terry_smith | 품질 복리 | "10년 보유할 기업인가?" |
| howard_marks | 사이클 + 리스크 | "지금 사이클 어디인가?" |
| druckenmiller | 매크로 + 타이밍 | "지금 진입 시점이 맞는가?" |
| bill_ackman | 행동주의 + 집중 | "가치를 끌어올릴 촉매가 있는가?" |

## 프레임워크 요약

| 투자자 | 핵심 지표 |
|--------|----------|
| Lynch | PEG < 1.0, 부채 < 80%, ROE ≥ 15% |
| Buffett | ROE 지속 ≥ 15%, Owner Earnings, 해자 |
| Fisher | 이익률 개선, R&D, 경영진 깊이 |
| Munger | ROIC > 15%, 이해 가능, FCF 전환 |

프레임워크 상세: `docs/frameworks/`
재무 지표 상세: `docs/financial_glossary.md`
