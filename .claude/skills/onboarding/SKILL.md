---
name: onboarding
description: 처음 접하는 기업에 대한 완전 정복 가이드를 작성합니다.
user-invocable: true
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

## 핵심 원칙

1. **Task 도구 필수**: 모든 Agent는 Task 도구로 실행 (메인 컨텍스트 절약)
2. **병렬 실행**: 5개 조사 Agent를 **단일 메시지에서 동시 호출**
3. **파일 저장**: 서브에이전트 결과는 파일로 저장, 메인에는 "완료"만 반환
4. **품질 우선**: 속도보다 깊이 있는 조사

---

## 워크플로우 요약

```
[1단계: 조사] - 5개 Agent 병렬
    ├─ business-model-analyst     → 1_business.md
    ├─ macro-analyst              → 2_macro.md
    ├─ primary-source-researcher  → 3_primary_source.md
    ├─ management-profiler        → 4_management.md
    └─ narrative-researcher       → 5_narrative.md
              │
[2단계: Article 작성]
    └─ onboarding-writer          → article.md
              │
[출력]
    └─ reports/[티커]/onboarding/article.md
```

상세: [워크플로우](workflow.md)

---

## 출력 파일 구조

```
reports/[티커]/onboarding/
├── 1_business.md       # 비즈니스 모델
├── 2_macro.md          # 매크로/산업
├── 3_primary_source.md # 1차 자료 (10-K, Earnings Call)
├── 4_management.md     # 경영진 프로필
├── 5_narrative.md      # 내러티브/시대적 맥락
└── article.md          # 최종 Article
```

**기존 파일 덮어씌움**: 이미 폴더가 존재하면 기존 파일을 덮어씌웁니다.

---

## 참조 파일

- [워크플로우 상세](workflow.md)
- [검색 전략 (공통)](search-strategy.md)
- [Agent 프롬프트](prompts/)

---

## deep_dive와의 차이점

| 구분 | deep_dive | onboarding |
|------|-----------|------------|
| 목적 | 투자 판단 | 기업 이해 |
| 출력 | 팩트시트 + Persona | 서술형 Article |
| 대상 | 이미 아는 사람 | 처음 접하는 사람 |
| Persona | 7개 해석 | 없음 (중립) |
| 용어집 | 없음 | 포함 |

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
- [ ] 용어집이 충분한가? (최소 10개)
- [ ] 출처가 명시되었는가?
- [ ] 투자 권유 표현이 없는가?
