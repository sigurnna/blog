---
name: onboarding
description: 처음 접하는 기업에 대한 완전 정복 가이드를 작성합니다. 10-30분 분량의 서술형 Article로, 산업 배경부터 투자자 멘탈 가이드까지 포함합니다.
allowed-tools: Task, Read, Write, WebSearch, WebFetch, Glob, Grep
---

# /onboarding [티커]

> 처음 접하는 기업의 "완전 정복 가이드" 생성

## 목적

처음 접하는 기업도 깊이 이해할 수 있도록 **10-30분 분량의 서술형 Article**을 생성한다.
단순 팩트시트가 아닌 **스토리텔링**으로 구성하며, 용어집을 포함하여 진입 장벽을 낮춘다.

## 사용법

```
/onboarding IREN
/onboarding RKLB
/onboarding ASTS
```

---

## 워크플로우

```
[1단계: 기초 조사] - 기존 Agent 활용 (간소화)
    ├─ business_model (핵심만)
    └─ macro_analyst (핵심만)
              │
[2단계: 심층 조사] - 신규 Agent 3개 병렬
    ├─ primary_source_researcher → 10-K, earnings call
    ├─ management_profiler → 경영진 분석
    └─ narrative_researcher → 시대적 맥락, 숨겨진 신호
              │
[3단계: Article 작성]
    └─ onboarding_writer → 서술형 통합
              │
[출력]
    └─ reports/[티커]/onboarding_YYYY-MM-DD.md
```

---

## 실행 지침

### 1단계: 기초 조사 (병렬)

두 Agent를 Task tool로 병렬 실행한다. **간소화 버전**으로 핵심만 수집.

```
Task 1: business_model (light)
- 핵심 사업 한 줄 정의
- 수익 모델 (구독/거래/라이선스 등)
- 주요 고객군
- 시장 규모 (TAM/SAM)

Task 2: macro_analyst (light)
- 산업 개요 (한 문단)
- 산업 성장률
- 주요 트렌드 1-2개
- Lynch 분류
```

### 2단계: 심층 조사 (병렬)

세 Agent를 Task tool로 병렬 실행한다. **흥신소 수준**의 깊이로 조사.

```
Task 3: primary_source_researcher
- SEC 10-K 핵심 섹션 (Business, Risk Factors, MD&A)
- 최근 2개 Earnings Call 분석
- 숨겨진 정보 (관련자 거래, 우발 부채 등)
- 핵심 인용문 수집

Task 4: management_profiler
- CEO/CFO 프로필 및 트랙레코드
- 보상 구조 (Proxy Statement)
- 내부자 거래 패턴
- "말 vs 행동" 분석
- Red Flags 체크

Task 5: narrative_researcher
- 시대의 병목 (해결하는 문제)
- 숨겨진 신호 (아직 대중이 모르는 것)
- 유동성/정책 수혜
- TCO 절감 구조
- M&A 전략 및 밸류체인
- 변동성 예상 및 멘탈 가이드
```

### 3단계: Article 작성

모든 조사 결과를 종합하여 서술형 Article 작성.

```
Task 6: onboarding_writer
- 입력: 1-5단계 모든 조사 결과
- 출력: 10-30분 분량 서술형 Article
- 요구사항:
  - 스토리텔링 구조
  - 전문 용어 첫 등장 시 설명
  - 용어집 포함
  - 출처 명시
  - 중립적 톤 (투자 권유 X)
```

---

## Task Agent 프롬프트 템플릿

### Task 1: business_model (light)

```
[티커] 기업의 비즈니스 모델을 간략히 조사해주세요.

수집 항목 (핵심만):
1. 핵심 사업 한 줄 정의
2. 수익 모델 (구독/거래/라이선스/하드웨어 등)
3. 주요 고객군 (B2B/B2C/정부)
4. 시장 규모 (TAM/SAM)

Agent 지침: .claude/agents/business_model.md 참조
출력: 간략한 텍스트 형태 (테이블 최소화)
```

### Task 2: macro_analyst (light)

```
[티커] 기업이 속한 산업과 매크로 환경을 간략히 조사해주세요.

수집 항목 (핵심만):
1. 산업 개요 (한 문단)
2. 산업 성장률 (CAGR)
3. 주요 트렌드 1-2개
4. Lynch 분류 (Fast Grower/Stalwart/Cyclical 등)

Agent 지침: .claude/agents/macro_analyst.md 참조
출력: 간략한 텍스트 형태
```

### Task 3: primary_source_researcher

```
[티커] 기업의 SEC 파일링과 Earnings Call을 심층 조사해주세요.

수집 항목:
1. 10-K 핵심 섹션 분석
   - Item 1 (Business): 사업 본질
   - Item 1A (Risk Factors): 회사가 인정하는 리스크
   - Item 7 (MD&A): 경영진 관점
2. 최근 2개 분기 Earnings Call
   - 톤 변화
   - 회피 패턴
   - 새로운 강조점
3. 숨겨진 정보
   - 관련자 거래
   - 우발 부채
   - 회계 정책 변경
4. 핵심 인용문 (원문 그대로)

Agent 지침: .claude/agents/primary_source_researcher.md 참조
출력: 상세 조사 결과
```

### Task 4: management_profiler

```
[티커] 기업의 경영진을 조사해주세요.

수집 항목:
1. CEO/CFO 프로필
   - 이전 경력
   - 트랙레코드
2. 보상 구조 (Proxy Statement DEF 14A)
   - 총 보상
   - 성과 연동 구조
3. 내부자 거래
   - 최근 12개월 패턴
   - 매수/매도 금액
4. "말 vs 행동" 분석
   - 가이던스 달성률
   - 약속 이행 여부
5. Red Flags 체크

Agent 지침: .claude/agents/management_profiler.md 참조
출력: 경영진 프로필 결과
```

### Task 5: narrative_researcher

```
[티커] 기업의 시대적 맥락과 내러티브를 조사해주세요.

수집 항목:
1. 시대의 병목
   - 해결하는 시대적 문제
   - AI/우주/로봇/비트코인 연결
2. 숨겨진 신호
   - 아직 대중이 모르는 힌트
   - 인지도 전환점
3. 유동성/정책 수혜
   - 금리 환경 영향
   - 정부 정책/보조금
4. TCO 절감 구조
   - 고객 가치 제안
5. M&A 전략 및 밸류체인
6. 투자자 멘탈 가이드
   - 예상 변동성
   - 하락 시 체크 포인트

Agent 지침: .claude/agents/narrative_researcher.md 참조
세상학개론 프레임워크: .claude/personas/stocks/sesang.md 참조
출력: 내러티브 조사 결과
```

### Task 6: onboarding_writer

```
지금까지 수집된 모든 조사 결과를 바탕으로 [티커] 온보딩 Article을 작성해주세요.

입력 자료:
1. 비즈니스 모델 조사 결과
2. 매크로 조사 결과
3. 1차 자료 조사 결과
4. 경영진 프로필
5. 내러티브 조사 결과

출력 요구사항:
- 10-30분 분량의 서술형 Article
- 스토리텔링 구조 (테이블 나열 X)
- 전문 용어 첫 등장 시 설명
- 용어집 포함
- 출처 명시
- 중립적 톤 (투자 권유 X)

Article 구조:
1. 한 줄 요약
2. 시대의 병목 - 왜 지금 이 기업인가?
3. 비즈니스 모델 - 어떻게 돈을 버는가?
4. 경쟁 구도 - 왜 이 기업이 이기는가?
5. 성장 전략 - 어떻게 커질 것인가?
6. 매크로 환경 - 유동성과 정책
7. 경영진 - 누가 이끄는가?
8. 핵심 숫자
9. 투자자 가이드 - 이 주식을 들면 이런 일을 겪는다
10. 용어집

Agent 지침: .claude/agents/onboarding_writer.md 참조
```

---

## 출력 파일

```
reports/
└── [티커]/
    └── onboarding_YYYY-MM-DD.md
```

---

## deep_dive와의 차이점

| 구분 | deep_dive | onboarding |
|------|-----------|------------|
| **목적** | 투자 판단 | 기업 이해 |
| **출력 형태** | 팩트시트 + Persona 해석 | 서술형 Article |
| **대상 독자** | 이미 기업을 아는 사람 | 처음 접하는 사람 |
| **Persona** | 7개 Persona 해석 | 없음 (중립) |
| **용어집** | 없음 | 포함 |
| **분량** | 짧은 팩트시트 다수 | 긴 Article 1개 |

---

## 사용 시나리오

### 1. 처음 듣는 기업 연구

```
> "RKLB가 뭐하는 회사야? 관심 있는데 기초부터 알고 싶어"
> /onboarding RKLB
```

### 2. deep_dive 전 사전 학습

```
> "IREN deep dive 하기 전에 기초 지식부터 쌓고 싶어"
> /onboarding IREN
> (Article 읽은 후)
> /deep_dive IREN
```

### 3. 포트폴리오 신규 종목 검토

```
> "이 종목 포트폴리오에 넣을지 검토 중인데 일단 파악부터"
> /onboarding OKLO
```

---

## 주의사항

- **컨텍스트 관리**: 모든 Agent는 Task tool로 실행하여 컨텍스트 분리
- **병렬 실행**: 가능한 Agent는 병렬로 실행하여 시간 단축
- **품질 우선**: 속도보다 깊이 있는 조사 우선
- **출처 필수**: 모든 주장에 출처 명시

---

## 체크리스트

실행 전:
- [ ] 티커가 정확한가?
- [ ] 미국 상장 기업인가?

실행 후:
- [ ] Article이 10-30분 분량인가?
- [ ] 용어집이 충분한가?
- [ ] 출처가 명시되었는가?
- [ ] 투자 권유 표현이 없는가?
