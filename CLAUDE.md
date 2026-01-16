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
3. **팩트와 해석 분리**: Agent는 팩트 수집, Persona만 해석
4. **존댓말 사용**: 사용자에게 항상 존댓말로 응대할 것. 반말 금지.

## 디렉토리 구조

```
.claude/
├── investor_profile.md       # 투자자 성향
├── portfolios.md             # 보유 자산
│
├── agents/                   # 팩트 수집 Agent (해석 안함)
│   ├── financial_analyst.md  # 재무 지표 수집
│   ├── business_model.md     # 비즈니스 모델 분석
│   ├── competitive_moat.md   # 경쟁 우위/해자 분석
│   ├── macro_analyst.md      # 매크로/산업 분석
│   ├── report_synthesizer.md # 팩트시트 통합
│   ├── investment_interpreter.md  # Persona 기반 해석
│   │
│   │   # Onboarding 전용 Agent
│   ├── primary_source_researcher.md  # 1차 자료 심층 조사
│   ├── management_profiler.md        # 경영진 프로파일링
│   ├── narrative_researcher.md       # 내러티브/시대적 맥락
│   └── onboarding_writer.md          # 서술형 Article 작성
│
├── personas/                 # 해석 관점
│   ├── stocks/               # 주식 투자 페르소나
│   │   ├── sesang.md             # 세상학개론 (내러티브+유동성)
│   │   ├── cathie_wood.md        # Cathie Wood (파괴적 혁신)
│   │   ├── michael_burry.md      # Michael Burry (역발상+Deep Value)
│   │   ├── terry_smith.md        # Terry Smith (품질 복리)
│   │   ├── howard_marks.md       # Howard Marks (사이클+리스크)
│   │   ├── stanley_druckenmiller.md # Druckenmiller (매크로+타이밍)
│   │   ├── bill_ackman.md        # Bill Ackman (행동주의+집중)
│   │   │
│   │   └── frameworks/           # 근간 프레임워크 (특별 취급)
│   │       ├── peter_lynch.md        # PEG, 성장률, GARP
│   │       ├── warren_buffett.md     # ROE, Owner Earnings, 해자
│   │       ├── philip_fisher.md      # 15포인트, 정성적 분석
│   │       └── charlie_munger.md     # ROIC, 멘탈모델, 역발상
│   │
│   └── crypto/               # 암호화폐 페르소나
│       └── oh_taemin.md          # 오태민 (비트코인 화폐철학+지정학)
│
└── commands/                 # Skill 커맨드
    ├── deep_dive.md              # 심층 분석 프로세스
    ├── onboarding.md             # 기업 완전 정복 가이드 (입문자용)
    ├── earnings_flash.md         # 실적 발표 직후 빠른 분석
    ├── discover_hidden_gems_from_x.md
    ├── sector_battle.md          # 섹터 내 페르소나 배틀
    ├── coach.md                  # 세상학개론 코치 (소크라테스식)
    ├── challenge.md              # Devil's Advocate (7개 페르소나 반론)
    └── thesis_check.md           # Thesis 유효성 빠른 점검

docs/                             # 사용자 참고 문서
└── financial_glossary.md         # 재무 용어집 (ROE, ROIC, PEG 등)

research/                         # 리서치 중인 종목 (thesis 작업용)
├── [티커]/
│   ├── thesis.md                 # 코치 모드 결과 (단일 파일, 업데이트 방식)
│   ├── challenge_YYYY-MM-DD.md   # 반론 결과
│   └── check_YYYY-MM-DD.md       # 유효성 점검 결과

reports/                          # 분석 리포트 저장 (정제된 결과물)
├── [티커]/                       # Deep Dive 결과
│   ├── YYYY-MM-DD/
│   │   ├── 1_financial.md        # 재무 팩트시트
│   │   ├── 2_business.md         # 비즈니스 모델 팩트시트
│   │   ├── 3_moat.md             # 경쟁 우위 팩트시트
│   │   ├── 4_macro.md            # 매크로 팩트시트
│   │   ├── 5_synthesized.md      # 통합 팩트시트
│   │   ├── 6_[persona].md        # Persona별 해석 (7개)
│   │   └── 7_final.md            # 중립 종합 리포트
│   │
│   └── onboarding_YYYY-MM-DD.md  # 기업 완전 정복 가이드
│
└── battles/                      # Sector Battle 결과
    └── [섹터-슬러그]/
        └── YYYY-MM-DD_HH-MM-SS/
            ├── 0_config.md       # 배틀 설정 + 대진표
            ├── 1_picks.md        # 1라운드: 전체 선택
            ├── 2_preliminary/    # 2라운드: 종목별 예선
            │   └── [종목]_*.md   # 예선 데스매치 기록
            ├── 3_semifinal/      # 3라운드: 4강
            │   └── match*.md     # 4강 데스매치 기록
            ├── 4_final.md        # 4라운드: 결승
            └── 5_summary.md      # 최종 결과
```

## Deep Dive 워크플로우

```
[1단계: 팩트 수집] - 4개 Agent 병렬
    ├─ financial_analyst
    ├─ business_model
    ├─ competitive_moat
    └─ macro_analyst
              │
[2단계: 통합] - 별도 Agent
    └─ report_synthesizer
              │
[3단계: 다각도 해석] - 7개 Persona 병렬
    ├─ 세상학개론 (공격/내러티브)
    ├─ Cathie Wood (공격/파괴적 혁신)
    ├─ Michael Burry (방어/역발상)
    ├─ Terry Smith (방어/품질)
    ├─ Howard Marks (방어/사이클)
    ├─ Druckenmiller (매크로/타이밍)
    └─ Bill Ackman (촉매/행동주의)
              │
[4단계: 중립 종합] - Persona 없이 집계
    └─ 투표 결과, 컨센서스, 논쟁점 정리
```

상세: `.claude/commands/deep_dive.md`

## Onboarding 워크플로우 (기업 완전 정복)

```
/onboarding [티커]

[1단계: 기초 조사] - 기존 Agent (간소화)
    ├─ business_model (light) → 사업 개요
    └─ macro_analyst (light) → 산업 개요
              │
[2단계: 심층 조사] - 신규 Agent 3개 병렬
    ├─ primary_source_researcher → SEC 10-K, Earnings Call
    ├─ management_profiler → 경영진 트랙레코드
    └─ narrative_researcher → 시대적 맥락, 숨겨진 신호
              │
[3단계: Article 작성]
    └─ onboarding_writer → 10-30분 분량 서술형 Article
              │
[출력]
    └─ reports/[티커]/onboarding_YYYY-MM-DD.md
```

**핵심 원칙**:
- 팩트시트가 아닌 **스토리텔링** 형태
- 처음 접하는 사람도 이해 가능 (용어집 포함)
- **흥신소 수준**의 깊이 (1차 자료 기반)
- 투자 권유 없이 중립적 톤

**deep_dive와 차이점**:
| 구분 | deep_dive | onboarding |
|------|-----------|------------|
| 목적 | 투자 판단 | 기업 이해 |
| 형태 | 팩트시트 + Persona | 서술형 Article |
| 대상 | 이미 아는 기업 | 처음 접하는 기업 |

상세: `.claude/commands/onboarding.md`

## Sector Battle 워크플로우 (토너먼트)

```
/sector-battle "AI 데이터센터"

[0단계: 초기화]
    └─ .claude/personas/stocks/*.md 스캔 (frameworks/ 제외)
    └─ 저장 디렉토리 생성: reports/battles/[섹터]/[타임스탬프]/
              │
[1라운드: 선택] - N개 Persona 병렬
    ├─ 각 페르소나가 섹터 내 최선의 종목 1개 선택
    └─ 대진표 생성 (같은 종목 → 예선 그룹)
              │
[2라운드: 종목별 예선] - 데스매치 (최대 5턴)
    ├─ 같은 종목 선택자끼리 1:1 토너먼트
    ├─ 확신도 3 이하 = KO, 5턴 후 높은 쪽 = 판정승
    └─ 각 종목별 대표 1명 선출
              │
[3라운드: 4강] - 데스매치
    └─ 종목 대표끼리 1:1 대결
              │
[4라운드: 결승] - 데스매치
    └─ 4강 승자끼리 최종 결승
              │
[5단계: 집계]
    └─ 토너먼트 결과 정리 + 명경기 하이라이트
```

**핵심 원칙**:
- 1 페르소나 = 1 Agent (컨텍스트 격리)
- 확신도 변화 있을 때까지 싸움 (최대 5턴)

상세: `.claude/commands/sector_battle.md`

## Thesis Building 워크플로우 (투자 근육 키우기)

```
/coach [티커]           # 1단계: 세상학개론 코치와 thesis 정리
                        #   - 빈 캔버스에서 시작
                        #   - 소크라테스식 질문으로 내 생각 유도
                        #   - "내 말"로 투자 논리 정리
              │
              ▼
/challenge [티커]       # 2단계: 7개 페르소나의 날카로운 반론
                        #   - 확증 편향 방지
                        #   - 못 본 리스크 발견
                        #   - 논리의 약점 노출
              │
              ▼
thesis 수정/강화        # 3단계: 반론 반영하여 보강
              │
              ▼
/thesis-check [티커]    # 4단계: 주기적 유효성 점검
                        #   - 주가 하락 시 thesis 깨졌는지 확인
                        #   - HOLD / WATCH / EXIT 판정
              │
              ▼
(반복)
```

**핵심 원칙**:
- 답을 주지 않고 **질문**으로 사고 유도
- 빌려온 철학이 아닌 **내 언어**로 체화
- 흔들릴 때 **팩트 기반** 점검으로 확신 유지

상세:
- `.claude/commands/coach.md`
- `.claude/commands/challenge.md`
- `.claude/commands/thesis_check.md`

## 사용 예시

```
"/onboarding RKLB"
→ RKLB 완전 정복 가이드 생성 (처음 접하는 기업용)
→ 10-30분 분량 서술형 Article + 용어집

"IREN deep dive 해줘"
→ 전체 워크플로우 실행 (기본: 세상학개론 관점)

"세상학개론 관점으로 분석해줘"
→ Persona 지정

"아그리파 관점으로도 봐줘"
→ 기존 팩트시트 + 다른 Persona로 재해석

"Michael Burry 관점으로 리스크 체크해줘"
→ 역발상/버블 관점 분석

"Terry Smith 관점으로 품질 평가해줘"
→ 장기 복리 관점 분석

"Druckenmiller 관점으로 타이밍 봐줘"
→ 매크로 환경 분석

"Bill Ackman 관점으로 분석해줘"
→ 행동주의/촉매 관점 분석

"/earnings-flash IREN FY25Q2"
→ 실적 발표 직후 빠른 분석 + 액션 판단

"/sector-battle AI 데이터센터"
→ 페르소나들이 섹터 내 최고 종목 선택 후 배틀
→ 4라운드 (선택→공격→반론→투표) 거쳐 승자 결정

"/coach IREN"
→ 세상학개론 코치와 소크라테스식 대화
→ 빈 캔버스에서 시작, 질문으로 내 thesis 정리

"/challenge IREN"
→ 7개 페르소나가 내 thesis를 날카롭게 공격
→ 확증 편향 방지, 약점 발견

"/thesis-check IREN"
→ 주가 하락 시 thesis 유효성 빠른 점검
→ HOLD / WATCH / EXIT 판정

"/thesis-check IREN 오늘 -15% 빠졌어"
→ 특정 이벤트 대응 점검
```

## Persona 요약

| Persona | 관점 | 핵심 질문 |
|---------|------|----------|
| 세상학개론 | 내러티브 + 유동성 | "시대의 병목을 해결하는가?" |
| Cathie Wood | 파괴적 혁신 | "5년 후 세상을 바꿀 기술인가?" |
| Michael Burry | 역발상 + Deep Value | "이게 버블 아닌가?" |
| Terry Smith | 품질 복리 | "10년 보유할 기업인가?" |
| Howard Marks | 사이클 + 리스크 | "지금 사이클 어디인가?" |
| Druckenmiller | 매크로 + 타이밍 | "지금 진입 시점이 맞는가?" |
| Bill Ackman | 행동주의 + 집중 | "가치를 끌어올릴 촉매가 있는가?" |

## 프레임워크 요약

| 투자자 | 핵심 지표 |
|--------|----------|
| Lynch | PEG < 1.0, 부채 < 80%, ROE ≥ 15% |
| Buffett | ROE 지속 ≥ 15%, Owner Earnings, 해자 |
| Fisher | 이익률 개선, R&D, 경영진 깊이 |
| Munger | ROIC > 15%, 이해 가능, FCF 전환 |

재무 지표 상세: `docs/financial_glossary.md`
