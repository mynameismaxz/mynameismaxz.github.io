SHELL := /bin/bash

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: run
run: ## Run the application
	@hugo server -D

.PHONY: create
create: ## Create a new post
	@read -p "Enter the post title: " title; \
	hugo new content content/posts/$$title.md

define print-target
    @printf "Executing target: \033[36m$@\033[0m\n"
endef