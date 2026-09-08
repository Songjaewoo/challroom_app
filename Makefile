# challroom_app — 자주 쓰는 명령 모음
#
#   make run        연결된 실기기(폰)로 실행
#   make verify     코드를 보여주기 전 항상 돌리는 3종 (gen → analyze → test)
#
# 서버 주소는 코드에 박지 않는다. 필요할 때 넘긴다:
#   make run API_BASE_URL=https://api.example.com
# 매번 치기 싫으면 .env.make 에 API_BASE_URL=... 한 줄을 적어 두면 자동으로 읽는다.

-include .env.make

FLUTTER ?= flutter
DART    ?= dart

# 연결된 물리 기기(iOS/Android)를 자동으로 고른다. 여러 대면 make run DEVICE=<id> 로 지정한다.
DEVICE ?= $(shell $(FLUTTER) devices --machine 2>/dev/null | python3 -c "import json,sys;\
d=json.load(sys.stdin);\
m=[x['id'] for x in d if x.get('targetPlatform','').startswith(('ios','android')) and not x.get('emulator')];\
print(m[0] if m else '')")

ifneq ($(strip $(API_BASE_URL)),)
DEFINES := --dart-define=API_BASE_URL=$(API_BASE_URL)
endif

.DEFAULT_GOAL := help
.PHONY: help deps gen watch run run-release devices analyze format test verify clean reset

help: ## 이 목록을 보여준다
	@grep -hE '^[a-z-]+:.*?## ' $(MAKEFILE_LIST) | awk -F':.*?## ' '{printf "  \033[36m%-12s\033[0m %s\n", $$1, $$2}'

deps: ## 패키지 설치
	$(FLUTTER) pub get

gen: ## 코드 생성 (*.g.dart, *.freezed.dart)
	$(DART) run build_runner build

watch: ## 코드 생성을 파일 저장마다 자동으로
	$(DART) run build_runner watch

run: ## 실기기로 실행 (debug)
	@test -n "$(DEVICE)" || { echo "실기기가 안 잡힙니다. 'make devices' 로 확인하고 make run DEVICE=<id> 로 지정하세요."; exit 1; }
	$(FLUTTER) run -d $(DEVICE) $(DEFINES)

run-release: ## 실기기로 실행 (release — 성능 확인용)
	@test -n "$(DEVICE)" || { echo "실기기가 안 잡힙니다. 'make devices' 로 확인하세요."; exit 1; }
	$(FLUTTER) run -d $(DEVICE) --release $(DEFINES)

devices: ## 연결된 기기 목록
	$(FLUTTER) devices

analyze: ## 정적 분석
	$(DART) analyze

format: ## 포매팅 (생성 파일 제외)
	$(DART) format lib test

test: ## 테스트
	$(FLUTTER) test

verify: gen analyze test ## 코드를 보여주기 전 항상 돌리는 3종

clean: ## 빌드 산출물 삭제
	$(FLUTTER) clean

reset: clean deps gen ## clean → pub get → 코드 생성
