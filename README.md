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
cd /Users/cdl/Downloads/CDL_ThesisStyle
make bachelor   # bachelor_sample.pdf
make master     # master_sample.pdf
```
内部では `latexmk -pdfdvi` により DVI→PDF（dvipdfmx）まで自動実行します。必要に応じて dvipdfmx を追実行して互換性を安定化します。

バイナリ場所を上書きしたい場合:
```bash
make master TEXBIN=/Library/TeX/texbin
```

### 3) よくある問題
- macOS「プレビュー」で日本語が空白になることがあります（PDF自体は正しい）。Acrobat / Chrome / Edge など別ビューワで確認してください。
- PATH 未設定だと `latexmk` / `uplatex` / `dvipdfmx` が見つかりません。`echo $PATH` に `/Library/TeX/texbin` が含まれているか確認してください。

### 4) クリーン
```bash
make clean      # 中間ファイル削除
make distclean  # 生成物含め全削除
```
