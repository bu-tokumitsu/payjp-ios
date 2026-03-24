# ビルド検証テスト実行手順

SPM経由でのライブラリ取得時のビルド・実行時エラーを検知するためのテスト実行手順です。

## テストターゲットの追加（初回のみ）

### Xcodeでの追加手順

1. **プロジェクトを開く**
   ```bash
   cd /Users/t.tokumitsu/Developer/project/pay/payjp-ios/example-swift
   open example-swift.xcodeproj
   ```

2. **新しいテストターゲットを追加**
   - プロジェクトナビゲーターでプロジェクト（example-swift）を選択
   - ターゲットリストの下部にある `+` ボタンをクリック
   - `iOS` → `Unit Testing Bundle` を選択
   - `Next` をクリック

3. **ターゲット設定**
   - Product Name: `example-swiftBuildTests`
   - Organization Identifier: `com.exmaple.jp.pay`
   - Team: 空欄のまま
   - Testing Target: `example-swift` を選択
   - `Finish` をクリック

4. **既存のテストファイルを使用**
   - Xcodeが自動生成した `example-swiftBuildTests.swift` ファイルを削除
   - プロジェクトナビゲーターで `example-swiftBuildTests` グループを右クリック
   - `Add Files to "example-swift"...` を選択
   - `example-swiftBuildTests/PAYJPBuildTests.swift` を選択
   - Target Membership で `example-swiftBuildTests` にチェック
   - `Add` をクリック

5. **SPM依存関係の追加**
   - `example-swiftBuildTests` ターゲットを選択
   - `General` タブ → `Frameworks, Libraries, and Embedded Content`
   - `+` ボタンをクリック
   - `PAYJP` パッケージを選択して追加

6. **ビルド設定の確認**
   - `Build Settings` タブで `IPHONEOS_DEPLOYMENT_TARGET` が 12.0 以上であることを確認

7. **スキームの設定**
   - Product → Scheme → Edit Scheme...
   - `Test` アクション を選択
   - `example-swiftBuildTests` が有効になっていることを確認

8. **保存**
   - Cmd+S でプロジェクトを保存

## テストの実行

### Xcode での実行

```bash
# Xcodeでプロジェクトを開く
open example-swift.xcodeproj

# Product → Test (Cmd+U) を実行
# または、Test Navigator (Cmd+6) から個別テストを実行
```

### コマンドラインでの実行

```bash
cd /Users/t.tokumitsu/Developer/project/pay/payjp-ios/example-swift

# すべてのビルドテストを実行
xcodebuild test \
  -project example-swift.xcodeproj \
  -scheme example-swift \
  -destination 'platform=iOS Simulator,name=iPhone 16' \
  -only-testing:example-swiftBuildTests

# 特定のテストクラスのみ実行
xcodebuild test \
  -project example-swift.xcodeproj \
  -scheme example-swift \
  -destination 'platform=iOS Simulator,name=iPhone 16' \
  -only-testing:example-swiftBuildTests/PAYJPBuildTests

# 特定のテストメソッドのみ実行
xcodebuild test \
  -project example-swift.xcodeproj \
  -scheme example-swift \
  -destination 'platform=iOS Simulator,name=iPhone 16' \
  -only-testing:example-swiftBuildTests/PAYJPBuildTests/testCardFormViewInitialization
```

### Fastlane での実行（Fastfile に追加後）

```bash
cd /Users/t.tokumitsu/Developer/project/pay/payjp-ios

# SPMビルドテストの実行
bundle exec fastlane ios test_spm_build
```

## テスト内容

以下の項目をテストします：

### PAYJP Core
- ✅ PAYJP クラスの初期化
- ✅ 公開鍵の設定

### モデル
- ✅ Token モデルへのアクセス
- ✅ Card モデルの初期化

### UI コンポーネント
- ✅ CardFormView の初期化
- ✅ CardFormStyle へのアクセス
- ✅ CardFormLabelStyle の初期化
- ✅ CardFormViewController へのアクセス

### API & その他
- ✅ APIClient へのアクセス
- ✅ ThreeDSecureProcessHandler へのアクセス
- ✅ PAYError へのアクセス
- ✅ リソースバンドルへのアクセス

## 期待される結果

### 成功ケース
- すべてのテストがパスする場合、SPM経由でのビルドが正常に動作しています

### 失敗ケース（これらは修正が必要な問題を示します）
- ❌ クラスが見つからない → SPMの依存関係設定に問題
- ❌ 初期化時にクラッシュ → リソース読み込みやバンドル設定に問題
- ❌ メソッド呼び出しに失敗 → APIの互換性に問題

## トラブルシューティング

### テストターゲットが見つからない
```bash
# プロジェクトのターゲットリストを確認
xcodebuild -list -project example-swift.xcodeproj

# example-swiftBuildTests がリストに表示されない場合は、
# 上記「テストターゲットの追加」手順を実施してください
```

### SPM依存関係が解決されない
```bash
# パッケージをリセット
rm -rf ~/Library/Developer/Xcode/DerivedData/example-swift-*

# Xcodeでプロジェクトを開き直す
open example-swift.xcodeproj
# File → Packages → Reset Package Caches
```

### シミュレータが起動しない
```bash
# 利用可能なシミュレータを確認
xcrun simctl list devices available

# 別のシミュレータを指定
xcodebuild test \
  -project example-swift.xcodeproj \
  -scheme example-swift \
  -destination 'platform=iOS Simulator,name=iPhone 15' \
  -only-testing:example-swiftBuildTests
```
