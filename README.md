# 노는법 레퍼런스 창고

노는법 마케팅팀이 같이 쓰는 레퍼런스 보드. GitHub Pages(호스팅) + Supabase(저장소).
개인용 reference-board를 복사해서 팀 공유용으로 바꾼 버전이에요.

- `index.html` — 사이트 전체
- `setup.sql` — Supabase 테이블·이미지 보관함·권한 설정

## 카테고리와 태그

**오가닉**
- 포맷: 릴스 · 카드뉴스 · 블로그 · 틱톡
- 참고 포인트(필수): 카피 · 디자인 · 기획

**paid-ads**
- 포맷: 이미지 · 영상 · 캐러셀
- 소구 방식: 할인율강조 · 부정화법 · 가격표시 · 마감임박/한정 · 후기/사회적증거
- 참고 포인트(필수): 카피 · 디자인

그 밖에 지역·업종 같은 건 "기타 태그"에 자유롭게. 태그를 바꾸고 싶으면 `index.html`의 `CATS` 부분만 고치면 돼요.

## 처음 한 번 설정

1. **Supabase 새 프로젝트 만들기** (개인용 프로젝트와 분리)
2. SQL Editor → New query → `setup.sql` 전체 붙여넣고 Run
3. **회원가입 막기**: Authentication 설정에서 새 사용자 가입 허용(Allow new users to sign up)을 끄기.
   켜져 있으면 사이트 주소를 아는 누구나 가입해서 볼 수 있어요.
4. **팀원 계정 만들기**: Authentication → Users → Add user → Create new user (Auto Confirm 체크)
5. Project Settings → API에서 Project URL과 publishable key를 복사해서
   `index.html`의 `SUPABASE_URL`, `SUPABASE_KEY`에 넣기
6. GitHub에 새 저장소(예: `nnb-reference-board`) 만들고 이 폴더 파일 전부 올리기
7. 저장소 Settings → Pages → Branch를 `main` / root로 저장하면 몇 분 뒤 주소가 생겨요

## 권한

로그인한 팀원은 모든 레퍼런스를 보고, 추가하고, 고치고, 지울 수 있어요.
카드 아래에 누가 저장했는지 표시돼요.
