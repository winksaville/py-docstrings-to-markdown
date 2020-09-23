.PHONY: help, markdown

.DEFAULT_GOAL := help

author="Wink Saville"

define PRINT_HELP_PYSCRIPT
import re, sys

for line in sys.stdin:
	match = re.match(r'^([a-zA-Z_-]+):.*?## (.*)$$', line)
	if match:
		target, help = match.groups()
		print("%-20s %s" % (target, help))
endef
export PRINT_HELP_PYSCRIPT

help:
	@python -c "$$PRINT_HELP_PYSCRIPT" < $(MAKEFILE_LIST)


#	(name=helix.py ;

markdown: clean ## Convert xxx.py to markdown/ with: make markdown app="path/to/xxx.py"
	(name=$$(basename ${app} .py) ;\
	echo name=$${name} ;\
	cp ${app} . ;\
	mkdir docs ;\
	sphinx-apidoc -o docs . sphinx-apidoc --full -A ${author} ;\
	cat docs/conf.py moreconf > docs/new.conf.py ;\
	mv docs/new.conf.py docs/conf.py ;\
	make -C docs markdown ;\
	mv docs/_build/markdown .)
	
clean: ## clean files
	rm -rf *.py docs/ markdown/
