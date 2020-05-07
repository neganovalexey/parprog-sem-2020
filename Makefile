SHELL = /bin/bash

AUX_DIR = aux
OUT_DIR = out
SRC_DIR = src
FIG_DIR = fig

PRESENTATION_NAMES = 02-13 02-20 02-27 03-05 03-12 03-19 03-19-lecture 03-26-lecture 04-02 04-08 04-16 04-23 04-30
PRESENTATIONS = $(addprefix $(OUT_DIR)/, $(addsuffix .pdf, $(PRESENTATION_NAMES)))

XELATEX = xelatex -synctex=1 -file-line-error -interaction=nonstopmode -halt-on-error -shell-escape -output-directory=$(AUX_DIR) $< \
 | grep ".*:[0-9]*:.*"; exit $${PIPESTATUS[0]}

.PHONY: all
all: $(PRESENTATIONS)

$(PRESENTATIONS): $(OUT_DIR)/%.pdf : $(SRC_DIR)/%.tex
	@echo "==>" $@
	@mkdir -p $(AUX_DIR)
	@$(call XELATEX)
	@$(call XELATEX)
	@mkdir -p $(OUT_DIR)
	@mv $(AUX_DIR)/$(notdir $@) $(OUT_DIR)

.PHONY: clean
clean:
	@echo "==>" $@
	@rm -rf $(AUX_DIR)/*
	@rm -rf $(OUT_DIR)/*
