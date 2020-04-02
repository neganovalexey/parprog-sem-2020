SHELL = /bin/bash

AUX_DIR = aux
OUT_DIR = out
SRC_DIR = src
FIG_DIR = fig

PRESENTATION_NAMES = 02-13.pdf 02-20.pdf 02-27.pdf 03-05.pdf 03-12.pdf 03-19.pdf 03-19-lecture.pdf 03-26-lecture.pdf 04-02.pdf
PRESENTATIONS = $(addprefix $(OUT_DIR)/, $(PRESENTATION_NAMES))

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
