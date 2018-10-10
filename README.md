# TabBar

#### やったこと
- タブ項目選択時にタブ項目のコンテンツ画面を表示
- タブ選択中の時は色を変更
- 未選択タブは一律で色を変更
- Aタブ(ボタンタップイベント契機で別タブに移動)
  - Aタブ内のボタンタップでCタブに移動
- Bタブ(子画面へのPush遷移)
  - 子画面を表示した状態でBタブをタップした時にBタブのトップに戻る
- Dタブ(トップのリストスクロールからのPush遷移)
  - スクロール状態でリストからPush遷移して子画面にいる状態でDタブを連続タップした時
    - Dタブのトップに戻る → Dタブのリストスクロールトップに戻る

#### おまけ
- タブをタップした時にバウンスアニメーション

#### イメージ

<img src="https://github.com/hsnm0112/TabBar/blob/master/Movie/sample.gif" width="250">
