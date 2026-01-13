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
│   └── investment_interpreter.md  # Persona 기반 해석
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
    ├── earnings_flash.md         # 실적 발표 직후 빠른 분석
    ├── discover_hidden_gems_from_x.md
    └── sector_battle.md          # 섹터 내 페르소나 배틀

reports/                          # 분석 리포트 저장
├── [티커]/                       # Deep Dive 결과
│   └── YYYY-MM-DD/
│       ├── 1_financial.md        # 재무 팩트시트
│       ├── 2_business.md         # 비즈니스 모델 팩트시트
│       ├── 3_moat.md             # 경쟁 우위 팩트시트
│       ├── 4_macro.md            # 매크로 팩트시트
│       ├── 5_synthesized.md      # 통합 팩트시트
│       ├── 6_[persona].md        # Persona별 해석 (6개)
│       └── 7_final.md            # 중립 종합 리포트
│
└── battles/                      # Sector Battle 결과
    └── [섹터-슬러그]/
        └── YYYY-MM-DD_HH-MM-SS/
            ├── 0_config.md       # 배틀 설정
            ├── 1_picks.md        # 1라운드: 선택
            ├── 2_attacks.md      # 2라운드: 공격
            ├── 3_rebuttals.md    # 3라운드: 반론
            ├── 4_votes.md        # 4라운드: 투표
            └── 5_final.md        # 최종 결과
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

## Sector Battle 워크플로우

```
/sector-battle "AI 데이터센터"

[0단계: 초기화]
    └─ .claude/personas/stocks/*.md 스캔 (frameworks/ 제외)
    └─ 저장 디렉토리 생성: reports/battles/[섹터]/[타임스탬프]/
              │
[1라운드: 선택] - N개 Persona 병렬 (각자 독립 Agent)
    ├─ 세상학개론 → "IREN"
    ├─ Cathie Wood → "TSLA"
    ├─ Burry → "PASS"
    ├─ Smith → "PASS"
    ├─ Howard Marks → "조건부 IREN"
    ├─ Druckenmiller → "NVDA"
    └─ Ackman → "EQIX"
              │
[2라운드: 공격] - N개 Persona 병렬 (각자 독립 Agent)
    └─ 다른 페르소나의 선택을 비판
              │
[3라운드: 반론] - N개 Persona 병렬 (각자 독립 Agent)
    └─ 자신에게 온 공격에 반박
              │
[4라운드: 투표] - N개 Persona 병렬 (각자 독립 Agent)
    └─ 본인 제외 1표 행사 + 패배 승복
              │
[5단계: 집계] - 중립 Agent (페르소나 없음)
    └─ 승자 선정 + 핵심 논쟁 정리
```

**핵심 원칙**: 1 페르소나 = 1 Agent (컨텍스트 격리)

상세: `.claude/commands/sector_battle.md`

## 사용 예시

```
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
