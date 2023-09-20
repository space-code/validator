all: bootstrap

bootstrap: hook
	mint bootstrap

hook:
	ln -sf ../../hooks/pre-commit .git/hooks/pre-commit
	chmod +x .git/hooks/pre-commit

mint:
	mint bootstrap

lint:
	mint run swiftlint

fmt:
	mint run swiftformat Sources Tests

.PHONY: all bootstrap hook mint lint fmt