# Onboarding 워크플로우 상세

## 1단계: 조사 (5개 Agent 병렬)

**목적**: 기업 정보 수집 (기초 + 심층)

| Agent | subagent_type | 출력 파일 | 수집 범위 |
|-------|---------------|----------|----------|
| 비즈니스 모델 | `business-model-analyst` | `1_business.md` | 사업 정의, 수익 모델, 고객군 |
| 매크로 분석 | `macro-analyst` | `2_macro.md` | 산업 개요, 트렌드, Lynch 분류 |
| 1차 자료 조사 | `primary-source-researcher` | `3_primary_source.md` | 10-K, Earnings Call |
| 경영진 프로필 | `management-profiler` | `4_management.md` | CEO/CFO, 내부자 거래 |
| 내러티브 조사 | `narrative-researcher` | `5_narrative.md` | 시대적 맥락, 숨겨진 신호 |

### 실행 방법

단일 메시지에서 5개의 Task 도구를 **병렬 호출**:

```
Task(subagent_type="business-model-analyst", prompt="...")
Task(subagent_type="macro-analyst", prompt="...")
Task(subagent_type="primary-source-researcher", prompt="...")
Task(subagent_type="management-profiler", prompt="...")
Task(subagent_type="narrative-researcher", prompt="...")
```

**프롬프트 템플릿**: [prompts/](prompts/) 디렉토리 참조

### 컨텍스트 관리

- 각 Agent는 **별도 프로세스**에서 독립 실행
- 메인 컨텍스트에 조사 내용이 쌓이지 않음
- WebSearch/WebFetch는 **서브에이전트 내에서만** 실행

---

## 2단계: Article 작성

**목적**: 5개 조사 결과를 서술형 Article로 통합

| Agent | subagent_type | 출력 파일 |
|-------|---------------|----------|
| 온보딩 라이터 | `onboarding-writer` | `article.md` |

### 실행 방법

1단계 완료 후 Task 도구 호출:

```
Task(subagent_type="onboarding-writer", prompt="...")
```

**프롬프트 템플릿**: [prompts/writer.md](prompts/writer.md) 참조

### 입력/출력

- **입력**: 1단계의 5개 조사 결과 (파일에서 읽음)
- **출력**: 10-30분 분량 서술형 Article

---

## Article 구조

1. **한 줄 요약** - 시대의 병목 한 문장
2. **시대의 병목** - 왜 지금 이 기업인가? (메가트렌드 연결)
3. **비즈니스 모델** - 어떻게 돈을 버는가? (TCO 절감 포함)
4. **경쟁 구도 & 해자** - 왜 이 기업이 이기는가?
5. **성장 촉매** - 앞으로 무슨 일이 일어나는가? (12-24개월)
6. **유동성 & 정책** - 돈의 물길은 어디로 흐르는가?
7. **경영진** - 말과 행동이 일치하는가? (Red Flags 체크)
8. **핵심 숫자** - 알아야 할 정량 지표
9. **투자자 멘탈 가이드** - 4R 체크리스트
10. **용어집** - 최소 10개

---

## 사용 시나리오

### 1. 처음 듣는 기업 연구

```
> "RKLB가 뭐하는 회사야? 기초부터 알고 싶어"
> /onboarding RKLB
```

### 2. deep_dive 전 사전 학습

```
> "IREN deep dive 하기 전에 기초부터"
> /onboarding IREN
> (Article 읽은 후)
> /deep_dive IREN
```

### 3. 일부 조사만 재실행

```
> "경영진 부분만 다시 조사해줘"
> Task(subagent_type="management-profiler", ...)로 해당 파일만 재생성
> 이후 onboarding-writer 재실행
```
