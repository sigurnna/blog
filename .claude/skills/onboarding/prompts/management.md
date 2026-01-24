# Management Profiler 프롬프트

## Task 호출

```
Task(
  subagent_type="management-profiler",
  description="[티커] 경영진 프로파일링",
  prompt="아래 프롬프트 내용"
)
```

---

## 프롬프트 템플릿

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

Agent 지침: .claude/agents/collectors/management.md 참조
출력 파일: reports/[티커]/onboarding/4_management.md

⚠️ 조사 완료 후 반드시 위 경로에 파일 저장. 메인에는 "완료" 메시지만 반환.
```

---

## 수집 항목 상세

| 항목 | 설명 | 필수 |
|------|------|------|
| CEO/CFO 프로필 | 이전 경력, 트랙레코드 | ✅ |
| 보상 구조 | DEF 14A 기반 | ✅ |
| 내부자 거래 | 12개월 패턴 | ⚪ |
| 가이던스 달성률 | 말 vs 행동 | ⚪ |
| Red Flags | 경고 신호 | ✅ |
