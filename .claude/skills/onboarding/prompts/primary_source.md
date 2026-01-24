# Primary Source Researcher 프롬프트

## Task 호출

```
Task(
  subagent_type="primary-source-researcher",
  description="[티커] 1차 자료 심층 조사",
  prompt="아래 프롬프트 내용"
)
```

---

## 프롬프트 템플릿

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

Agent 지침: .claude/agents/collectors/primary_source.md 참조
출력 파일: reports/[티커]/onboarding/3_primary_source.md

⚠️ 조사 완료 후 반드시 위 경로에 파일 저장. 메인에는 "완료" 메시지만 반환.
```

---

## 수집 항목 상세

| 항목 | 설명 | 필수 |
|------|------|------|
| 10-K Item 1 | 사업 본질 설명 | ✅ |
| 10-K Item 1A | 리스크 팩터 | ✅ |
| 10-K Item 7 | MD&A | ✅ |
| Earnings Call 톤 | 최근 2분기 톤 변화 | ✅ |
| 숨겨진 정보 | 관련자 거래, 우발 부채 등 | ⚪ |
| 핵심 인용문 | 원문 그대로 | ✅ |
