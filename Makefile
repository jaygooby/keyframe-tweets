ETH ?= en0
IP := $(shell ifconfig $(ETH) | grep "inet " | grep -v 127.0.0.1|awk 'match($$0, /([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+)/) {print substr($$0,RSTART,RLENGTH)}')
SPEAKER ?= $(shell date +'%s')

capture:
	./i-framer rtmp://$(IP)/live/tweets ${SPEAKER}

url:
	@echo rtmp://$(IP)/live/tweets
