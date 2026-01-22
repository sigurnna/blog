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

## ⚠️ 컨텍스트 관리 원칙

**반드시 Task 도구를 사용하여 서브에이전트로 실행할 것!**

- 각 Agent는 **Task 도구**로 실행 (메인 컨텍스트 절약)
- 서브에이전트 결과는 **파일로 저장** 후 메인에는 완료 여부만 반환
- 병렬 실행 가능한 Agent는 **단일 메시지에 여러 Task 호출**로 동시 실행
- WebSearch/WebFetch는 **서브에이전트 내에서만** 실행

---

## 🔍 검색 전략 (모든 조사 Agent 공통)

**넓은 검색에서 시작하여 점진적으로 좁히기**

```
1단계: 넓은 검색
   "[기업명]" or "[티커]" 단독 검색
   → 어떤 정보가 있는지 파악

2단계: 결과 평가
   → 1차 자료(SEC, IR)가 있는가?
   → 신뢰할 수 있는 소스인가?

3단계: 점진적 구체화
   "[기업명] 10-K 2024" or "[기업명] earnings call Q3"
   → 필요한 정보로 좁히기

4단계: 링크 추적 (필요시)
   → 유용한 소스의 인용/참조 따라가기
   → 최대 3-depth까지 (원본 → 인용 → 인용의 인용)
```

**하지 말 것**: 처음부터 너무 구체적인 검색 (예: "[기업명] revenue breakdown by segment Q3 2024 investor presentation")

---

## ✅ 완료 기준 (모든 조사 Agent 공통)

### 1. 필수 항목 기반 (Primary)
- 프롬프트에 명시된 **필수 수집 항목**이 모두 채워지면 해당 섹션 완료
- 채워지지 않은 항목이 있으면 추가 검색

### 2. 1차 자료 우선 원칙
- **SEC 10-K/10-Q에서 정보 확보** → 해당 항목 완료 (추가 검색 불필요)
- **Earnings Call transcript 확보** → 해당 항목 완료
- 1차 자료에서 못 찾은 항목만 2차 자료(뉴스, 분석) 검색

### 3. 수확 체감 규칙 (무한루프 방지)
- **연속 3번 검색에서 새로운 핵심 정보가 없으면** → 해당 항목 "정보 없음/확인 불가"로 처리
- "정보 없음"도 유의미한 결과 → 반드시 기록

### 4. 링크 추적 depth 제한
- 유용한 소스 발견 시 **링크 따라가기 허용**
- 단, **최대 3-depth**까지 (원본 → 1차 인용 → 2차 인용)
- 각 depth에서 핵심 정보 발견 시 기록 후 복귀

---

## 워크플로우

```
[1단계: 조사] - 5개 Agent 병렬 실행 (단일 메시지에서 동시 호출)
    ├─ business_model (light)     → 1_business.md
    ├─ macro_analyst (light)      → 2_macro.md
    ├─ primary_source_researcher  → 3_primary_source.md
    ├─ management_profiler        → 4_management.md
    └─ narrative_researcher       → 5_narrative.md
              │
              ▼ (5개 모두 완료 대기)
[2단계: Article 작성]
    └─ onboarding_writer          → article.md (파일에서 읽어서 통합)
              │
              ▼
[출력]
    └─ reports/[티커]/onboarding/article.md
```

---

## 출력 파일 구조

```
reports/
└── [티커]/
    └── onboarding/                 # 단일 폴더 (날짜 없음)
        ├── 1_business.md           # business_model 결과
        ├── 2_macro.md              # macro_analyst 결과
        ├── 3_primary_source.md     # primary_source_researcher 결과
        ├── 4_management.md         # management_profiler 결과
        ├── 5_narrative.md          # narrative_researcher 결과
        └── article.md              # 최종 Article
```

**⚠️ 기존 파일 덮어씌움**: 이미 onboarding 폴더가 존재하면 기존 파일을 덮어씌웁니다. 이전 버전이 필요하면 미리 백업하세요.

---

## 단계별 상세

### 1단계: 조사 (5개 Agent 병렬)

**목적**: 기업 정보 수집 (기초 + 심층)

| Agent | subagent_type | 출력 파일 | 수집 범위 |
|-------|---------------|----------|----------|
| 비즈니스 모델 | `business-model-analyst` | `1_business.md` | 사업 정의, 수익 모델, 고객군 |
| 매크로 분석 | `macro-analyst` | `2_macro.md` | 산업 개요, 트렌드, Lynch 분류 |
| 1차 자료 조사 | `primary-source-researcher` | `3_primary_source.md` | 10-K, Earnings Call |
| 경영진 프로필 | `management-profiler` | `4_management.md` | CEO/CFO, 내부자 거래 |
| 내러티브 조사 | `narrative-researcher` | `5_narrative.md` | 시대적 맥락, 숨겨진 신호 |

**실행 방법**: 단일 메시지에서 5개의 Task 도구를 **병렬 호출**

```
Task(subagent_type="business-model-analyst", prompt="[티커] 비즈니스 모델 조사 (light). 결과를 reports/[티커]/onboarding/1_business.md에 저장")
Task(subagent_type="macro-analyst", prompt="[티커] 매크로/산업 조사 (light). 결과를 reports/[티커]/onboarding/2_macro.md에 저장")
Task(subagent_type="primary-source-researcher", prompt="[티커] SEC 파일링/Earnings Call 심층 조사. 결과를 reports/[티커]/onboarding/3_primary_source.md에 저장")
Task(subagent_type="management-profiler", prompt="[티커] 경영진 프로파일링. 결과를 reports/[티커]/onboarding/4_management.md에 저장")
Task(subagent_type="narrative-researcher", prompt="[티커] 내러티브/시대적 맥락 조사. 결과를 reports/[티커]/onboarding/5_narrative.md에 저장")
```

**컨텍스트**: 각 Agent는 **별도 프로세스**에서 독립 실행 → 메인 컨텍스트에 조사 내용 안 쌓임

**출력**: 5개의 개별 조사 결과 (파일로 저장됨)

---

### 2단계: Article 작성

**목적**: 5개 조사 결과를 서술형 Article로 통합

| Agent | subagent_type | 출력 파일 |
|-------|---------------|----------|
| 온보딩 라이터 | `onboarding-writer` | `article.md` |

**실행 방법**: 1단계 완료 후 Task 도구 호출

```
Task(subagent_type="onboarding-writer", prompt="[티커] 온보딩 Article 작성. 입력: reports/[티커]/onboarding/의 1~5번 조사 결과. 출력: 같은 폴더에 article.md로 저장")
```

**입력**: 1단계의 5개 조사 결과 (파일에서 읽음)

**컨텍스트**: 서브에이전트가 파일을 직접 읽어서 처리 → 메인 컨텍스트에 조사 내용 안 쌓임

**출력**: 10-30분 분량 서술형 Article (파일로 저장됨)

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

Agent 지침: .claude/agents/deep_dive/business_model.md 참조
출력 파일: reports/[티커]/onboarding/1_business.md
출력 형태: 간략한 텍스트 (테이블 최소화)

⚠️ 조사 완료 후 반드시 위 경로에 파일 저장. 메인에는 "완료" 메시지만 반환.
```

### Task 2: macro_analyst (light)

```
[티커] 기업이 속한 산업과 매크로 환경을 간략히 조사해주세요.

수집 항목 (핵심만):
1. 산업 개요 (한 문단)
2. 산업 성장률 (CAGR)
3. 주요 트렌드 1-2개
4. Lynch 분류 (Fast Grower/Stalwart/Cyclical 등)

Agent 지침: .claude/agents/deep_dive/macro_analyst.md 참조
출력 파일: reports/[티커]/onboarding/2_macro.md
출력 형태: 간략한 텍스트

⚠️ 조사 완료 후 반드시 위 경로에 파일 저장. 메인에는 "완료" 메시지만 반환.
```

### Task 3: primary_source_researcher

```
[티커] 기업의 SEC 파일링과 Earnings Call을 심층 조사해주세요.

## 필수 수집 항목
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

## 검색 전략
1. 넓게 시작: "[티커] SEC filing" or "[티커] 10-K"
2. 결과 평가 후 구체화: "[티커] 10-K 2024 site:sec.gov"
3. Earnings Call: "[기업명] earnings call transcript Q[N] 2024"
4. 유용한 인용 발견 시 원본 따라가기 (최대 3-depth)

## 완료 기준
- 10-K 핵심 3개 섹션 확보 → 1번 항목 완료
- Earnings Call 2개 확보 → 2번 항목 완료
- 숨겨진 정보: 10-K 주석(Notes)에서 확인, 없으면 "확인 불가" 기록
- 연속 3번 검색에서 새 정보 없으면 → 해당 항목 종료

Agent 지침: .claude/agents/onboarding/primary_source_researcher.md 참조
출력 파일: reports/[티커]/onboarding/3_primary_source.md

⚠️ 조사 완료 후 반드시 위 경로에 파일 저장. 메인에는 "완료" 메시지만 반환.
```

### Task 4: management_profiler

```
[티커] 기업의 경영진을 조사해주세요.

## 필수 수집 항목
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

## 검색 전략
1. 넓게 시작: "[CEO 이름]" or "[기업명] CEO"
2. 공식 자료 우선: "[티커] DEF 14A site:sec.gov" (Proxy Statement)
3. 내부자 거래: "[티커] insider trading" or "openinsider [티커]"
4. 트랙레코드: "[CEO 이름] previous company" or "[CEO 이름] track record"
5. 인터뷰/발언: "[CEO 이름] interview" or "[기업명] investor day"

## 완료 기준
- DEF 14A에서 보상 구조 확보 → 2번 항목 완료
- CEO/CFO 기본 프로필 확보 → 1번 항목 완료
- 내부자 거래: 공개 데이터 확인, 없으면 "공개 거래 없음" 기록
- 가이던스 vs 실적: 최근 4분기 비교 가능하면 완료, 불가시 "데이터 부족" 기록
- 연속 3번 검색에서 새 정보 없으면 → 해당 항목 종료

Agent 지침: .claude/agents/onboarding/management_profiler.md 참조
출력 파일: reports/[티커]/onboarding/4_management.md

⚠️ 조사 완료 후 반드시 위 경로에 파일 저장. 메인에는 "완료" 메시지만 반환.
```

### Task 5: narrative_researcher

```
[티커] 기업의 시대적 맥락과 내러티브를 조사해주세요.

## 필수 수집 항목
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

## 검색 전략
1. 넓게 시작: "[기업명] thesis" or "[기업명] investment case"
2. 정책/보조금: "[산업] government funding" or "[산업] IRA subsidy"
3. 메가트렌드 연결: "[기업명] AI infrastructure" or "[기업명] [메가트렌드]"
4. M&A: "[기업명] acquisition" or "[기업명] M&A strategy"
5. 전문가 분석: "[기업명] deep dive analysis" or "[기업명] bull case bear case"
6. 유용한 분석 발견 시 인용 소스 따라가기 (최대 3-depth)

## 완료 기준
- 시대의 병목: 메가트렌드 1개 이상 연결 확인 → 1번 항목 완료
- 정책 수혜: 관련 정책 확인 또는 "직접 수혜 없음" 기록 → 3번 항목 완료
- M&A: 최근 3년 인수 이력 확인 또는 "인수 이력 없음" 기록 → 5번 항목 완료
- 숨겨진 신호: 대중 인지도 낮은 정보 1개 이상 발견 시 완료, 없으면 "특이사항 없음" 기록
- 연속 3번 검색에서 새 정보 없으면 → 해당 항목 종료

Agent 지침: .claude/agents/onboarding/narrative_researcher.md 참조
세상학개론 프레임워크: .claude/personas/stocks/sesang.md 참조
출력 파일: reports/[티커]/onboarding/5_narrative.md

⚠️ 조사 완료 후 반드시 위 경로에 파일 저장. 메인에는 "완료" 메시지만 반환.
```

### Task 6: onboarding_writer

```
[티커] 온보딩 Article을 작성해주세요.

입력 파일 (모두 읽을 것):
- reports/[티커]/onboarding/1_business.md
- reports/[티커]/onboarding/2_macro.md
- reports/[티커]/onboarding/3_primary_source.md
- reports/[티커]/onboarding/4_management.md
- reports/[티커]/onboarding/5_narrative.md

출력 요구사항:
- 10-30분 분량의 서술형 Article
- 스토리텔링 구조 (테이블 나열 X)
- 전문 용어 첫 등장 시 설명
- 용어집 포함
- 출처 명시
- 중립적 톤 (투자 권유 X)

Article 구조 (상세 형식은 Agent 지침 참조):
1. 한 줄 요약 (시대의 병목 한 문장)
2. 시대의 병목 - 왜 지금 이 기업인가? (메가트렌드 연결)
3. 비즈니스 모델 - 어떻게 돈을 버는가? (TCO 절감 포함)
4. 경쟁 구도 & 해자 - 왜 이 기업이 이기는가?
5. 성장 촉매 - 앞으로 무슨 일이 일어나는가? (단기 촉매 12-24개월)
6. 유동성 & 정책 - 돈의 물길은 어디로 흐르는가? (소버린 AI 포함)
7. 경영진 - 말과 행동이 일치하는가? (Red Flags 체크)
8. 핵심 숫자
9. 투자자 멘탈 가이드 - 4R 체크리스트 (Read-Reaction-Repeat-Review)
10. 용어집 (최소 10개)

Agent 지침: .claude/agents/onboarding/onboarding_writer.md 참조
출력 파일: reports/[티커]/onboarding/article.md

⚠️ 작성 완료 후 반드시 위 경로에 파일 저장. 메인에는 "완료" 메시지만 반환.
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

### 4. 일부 조사만 재실행

```
> "경영진 부분만 다시 조사해줘"
> Task(subagent_type="management-profiler", prompt="...")로 해당 파일만 재생성
> 이후 onboarding_writer 재실행
```

---

## 주의사항

- **컨텍스트 관리**: 모든 Agent는 Task tool로 실행, 결과는 파일 저장
- **병렬 실행**: 5개 조사 Agent를 **단일 메시지에서 동시 호출** 필수
- **품질 우선**: 속도보다 깊이 있는 조사 우선
- **출처 필수**: 모든 주장에 출처 명시

---

## 체크리스트

실행 전:
- [ ] 티커가 정확한가?
- [ ] 미국 상장 기업인가?

실행 중:
- [ ] 5개 조사 Agent를 단일 메시지에서 병렬 호출했는가?
- [ ] 각 Agent가 파일에 결과를 저장했는가?

실행 후:
- [ ] Article이 10-30분 분량인가?
- [ ] 용어집이 충분한가?
- [ ] 출처가 명시되었는가?
- [ ] 투자 권유 표현이 없는가?
