# Onboarding Writer 프롬프트

## Task 호출

```
Task(
  subagent_type="onboarding-writer",
  description="[티커] 온보딩 Article 작성",
  prompt="아래 프롬프트 내용"
)
```

---

## 프롬프트 템플릿

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

Agent 지침: .claude/agents/synthesizers/onboarding_writer.md 참조
출력 파일: reports/[티커]/onboarding/article.md

⚠️ 작성 완료 후 반드시 위 경로에 파일 저장. 메인에는 "완료" 메시지만 반환.
```

---

## Article 섹션 상세

| 섹션 | 내용 | 분량 |
|------|------|------|
| 한 줄 요약 | 시대의 병목 한 문장 | 1줄 |
| 시대의 병목 | 메가트렌드 연결 | 2-3 문단 |
| 비즈니스 모델 | 수익 구조, TCO 절감 | 3-4 문단 |
| 경쟁 구도 & 해자 | 경쟁사 비교, 차별점 | 2-3 문단 |
| 성장 촉매 | 12-24개월 이벤트 | 2-3 문단 |
| 유동성 & 정책 | 금리, 보조금, 소버린 AI | 2-3 문단 |
| 경영진 | 프로필, Red Flags | 2-3 문단 |
| 핵심 숫자 | 정량 지표 | 테이블 1개 |
| 멘탈 가이드 | 4R 체크리스트 | 1-2 문단 |
| 용어집 | 전문 용어 설명 | 최소 10개 |

---

## 작성 원칙

1. **스토리텔링**: 테이블 나열이 아닌 서술형
2. **초보자 친화**: 전문 용어 첫 등장 시 괄호 설명
3. **중립적 톤**: "투자하라/하지 마라" 표현 금지
4. **출처 명시**: 모든 주장에 근거
5. **4R 체크리스트**:
   - **R**ead: 무엇을 읽어야 하나
   - **R**eaction: 어떤 상황에 어떻게 반응할 것인가
   - **R**epeat: 주기적으로 확인할 것
   - **R**eview: 언제 thesis를 재검토할 것인가
