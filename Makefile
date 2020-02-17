SHELL = /bin/bash

AUX_DIR = aux
OUT_DIR = out
SRC_DIR = src
FIG_DIR = fig

PRESENTATIONS = $(OUT_DIR)/02-13.pdf

XELATEX = xelatex -synctex=1 -file-line-error -interaction=nonstopmode -halt-on-error -output-directory=$(AUX_DIR) $< \
 | grep ".*:[0-9]*:.*"; exit $${PIPESTATUS[0]}

.PHONY: all
all: $(PRESENTATIONS)

$(PRESENTATIONS): $(OUT_DIR)/%.pdf : $(SRC_DIR)/%.tex $(wildcard $(SRC_DIR)/*.bib) $(wildcard $(FIG_DIR)/*)
	@echo "==>" $@
	@mkdir -p $(AUX_DIR)
	@$(call XELATEX)
	@biber -q $(AUX_DIR)/$(notdir $(basename $<))
	@$(call XELATEX)
	@mkdir -p $(OUT_DIR)
	@mv $(AUX_DIR)/$(notdir $@) $(OUT_DIR)

.PHONY: clean
clean:
	@echo "==>" $@
	@rm -f $(AUX_DIR)/*
	@rm -f $(OUT_DIR)/*
