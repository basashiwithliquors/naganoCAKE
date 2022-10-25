# ながのCAKE

『長野県にある小さな洋菓子店「ながのCAKE」の商品を通販するためのECサイト』という設定で、DMM WEBCAMPのチーム開発で制作したサイト。

## サイト概要

* ユーザーはジャンル検索なども活用し、商品の閲覧から注文まで直感的に操作できるUIになっている。
* 商品の販売については、注文に応じて製作する受注生産型を採用している。1日の受注量に制限はない。
* 送料は1配送につき全国一律800円。
* 友人や家族へのプレゼントなど、注文者の住所以外にも商品を発送できる。
* 支払方法はクレジットカード、銀行振込から選択可能。

## 実装機能
### ■顧客側
* 会員登録、ログイン・ログアウト、退会ができる。
* ログインはメールアドレスとパスワードで行うことができる。
* 商品をカートに入れ、1度に複数種類、複数商品の購入ができる。また、カート内の商品は個数変更・削除ができる。
* サイトの閲覧はログインなしで行えるが、カートへの商品追加はログインが必要。
* 会員は配送先を複数登録しておくことが可能。
* 会員はマイページから、会員情報の閲覧・編集、注文履歴の閲覧、配送先の閲覧・編集ができる
* 商品はジャンルごとに絞り込みができる

### ■管理者側
* 管理者用メールアドレスとパスワードでログインできる。  
`メールアドレス：test@test.com`  
`パスワード：111111`  
※$ rails db:seedを実行後、ログイン可能
* 商品について、新規追加、編集、閲覧、販売停止ができる。
* 商品に紐づくジャンルの新規追加、編集ができる。
* 会員登録されているユーザ情報の閲覧、編集、退会処理が行える。
* 顧客の注文履歴を一覧・詳細表示できる。
* 注文ごとに注文ステータスの更新、注文商品ごとに製作ステータスの更新ができる。

## 開発環境
* Ruby 3.1.2
* Rails 6.1.7

## 作成者

2022年9月生 チームI 「馬刺しとリカーズ」
