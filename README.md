## ビルド（macOS）

このテンプレートは upLaTeX + dvipdfmx を想定しています。`Makefile` でワンコマンドビルドできます。

### 1) セットアップ
```bash
# 推奨（簡単）
brew install --cask mactex-no-gui
echo 'export PATH="/Library/TeX/texbin:$PATH"' >> ~/.zprofile && source ~/.zprofile
```
BasicTeX を使う場合:
```bash
brew install --cask basictex
echo 'export PATH="/Library/TeX/texbin:$PATH"' >> ~/.zprofile && source ~/.zprofile
sudo tlmgr update --self
sudo tlmgr install latexmk uplatex dvipdfmx collection-langjapanese ptex-fontmaps haranoaji
```

### 2) ビルド
```bash

# 任意のファイル名でビルド（拡張子なし）
make main       # main.tex → main.pdf
make bachelor   # bachelor_sample.tex → bachelor_sample.pdf
make master     # master_sample.tex → master_sample.pdf

# ディレクトリ内の全 .tex をPDF化
make
```
内部では `.latexmkrc` の設定により upLaTeX→DVI→PDF（dvipdfmx）まで自動実行します。

バイナリ場所を上書きしたい場合:
```bash
make master TEXBIN=/Library/TeX/texbin
```

### 3) よくある問題
- macOS「プレビュー」で日本語が空白になることがあります（PDF自体は正しい）。Acrobat / Chrome / Edge など別ビューワで確認してください。
- PATH 未設定だと `latexmk` / `uplatex` / `dvipdfmx` が見つかりません。`echo $PATH` に `/Library/TeX/texbin` が含まれているか確認してください。

### 4) クリーン
```bash
make clean           # 全 .tex の補助ファイル削除
make clean-main      # main.tex の補助ファイルのみ削除
make distclean       # 全 .tex の生成物（PDF含む）削除
make distclean-main  # main.tex の生成物（PDF含む）削除
```

### 5) 自動ビルド（watch）
保存（Ctrl+S / Cmd+S）するたびに自動再ビルドします。PDFビューアは各自で開いたままにしてください。
```bash
# 任意ファイルでウォッチ
make watch-main

# 修論
make watch-master
# 卒論
make watch-bachelor
```
（内部的に `latexmk -pdfdvi -pvc` が走ります）
