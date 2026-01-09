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
├── frameworks/               # 투자자 프레임워크
│   ├── peter_lynch.md        # PEG, 성장률, GARP
│   ├── warren_buffett.md     # ROE, Owner Earnings, 해자
│   ├── philip_fisher.md      # 15포인트, 정성적 분석
│   └── charlie_munger.md     # ROIC, 멘탈모델, 역발상
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
│   ├── sesang.md             # 세상학개론 (내러티브+유동성)
│   └── agrippa_investments.md # 아그리파 (인프라 자산)
│
├── workflows/                # 워크플로우
│   └── deep_dive.md          # 심층 분석 프로세스
│
└── commands/                 # Skill 커맨드
    └── discover_hidden_gems_from_x.md

data/
├── raw/                      # 원본 데이터
└── processed/                # 분석 리포트 저장
    └── YYYY-MM-DD_[티커]_[persona].md
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
[3단계: 해석] - 별도 Agent + Persona
    └─ investment_interpreter
```

상세: `.claude/workflows/deep_dive.md`

## 사용 예시

```
"IREN deep dive 해줘"
→ 전체 워크플로우 실행

"세상학개론 관점으로 분석해줘"
→ Persona 지정

"아그리파 관점으로도 봐줘"
→ 기존 팩트시트 + 다른 Persona로 재해석
```

## 프레임워크 요약

| 투자자 | 핵심 지표 |
|--------|----------|
| Lynch | PEG < 1.0, 부채 < 80%, ROE ≥ 15% |
| Buffett | ROE 지속 ≥ 15%, Owner Earnings, 해자 |
| Fisher | 이익률 개선, R&D, 경영진 깊이 |
| Munger | ROIC > 15%, 이해 가능, FCF 전환 |
