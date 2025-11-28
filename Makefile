# TeXバイナリの場所（必要に応じて上書き可能）
TEXBIN ?= /Library/TeX/texbin
LATEXMK ?= $(TEXBIN)/latexmk
DVIPDFMX ?= $(TEXBIN)/dvipdfmx
DVIPDFMX_OPTS ?=
LATEXMK_OPTS ?=

## 動的ターゲット設定
# ディレクトリ内の .tex を自動検出
TEX_SRCS := $(wildcard *.tex)
PDFS := $(TEX_SRCS:.tex=.pdf)

.PHONY: all
# すべての .tex から PDF を生成
all: $(PDFS)

# 便宜上、既存のエイリアスを残す（存在する場合のみ有効）
.PHONY: bachelor master
bachelor: bachelor_sample.pdf
master: master_sample.pdf

# `make main` のように拡張子なしでビルド
%: %.pdf
	@true

# 基本ビルドルール（latexmk の設定は .latexmkrc に委譲）
%.pdf: %.tex
	$(LATEXMK) -f $(LATEXMK_OPTS) $<

.PHONY: watch-% watch-bachelor watch-master
# 自動再ビルド（ビューアは各自で開く）
watch-%:
	$(LATEXMK) -pvc -f $(LATEXMK_OPTS) $*.tex

# 既存の個別ウォッチも維持
watch-bachelor:
	$(LATEXMK) -pvc -f $(LATEXMK_OPTS) bachelor_sample.tex
watch-master:
	$(LATEXMK) -pvc -f $(LATEXMK_OPTS) master_sample.tex

.PHONY: clean clean-% distclean distclean-%
# 補助ファイルのみ削除（全ファイル）
clean:
	@for f in $(TEX_SRCS); do \
		$(LATEXMK) -c $(LATEXMK_OPTS) $$f || true; \
	done
# 補助ファイルのみ削除（対象指定：make clean-main）
clean-%:
	$(LATEXMK) -c $(LATEXMK_OPTS) $*.tex || true

# PDF を含む生成物を削除（全ファイル）
distclean:
	@for f in $(TEX_SRCS); do \
		$(LATEXMK) -C $(LATEXMK_OPTS) $$f || true; \
	done
# PDF を含む生成物を削除（対象指定：make distclean-main）
distclean-%:
	$(LATEXMK) -C $(LATEXMK_OPTS) $*.tex || true


