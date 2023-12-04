import 'dart:convert';

const Map<String, String> jp_JP = {
  "Not authorized": "許可されていません",
  "scanFingure": "スキャン人物",
  "Enter Password": "パスワードを入力する",
  "Password": "パスワード",
  "Cancel": "キャンセル",
  "CANCEL": "キャンセル",
  "Enter correct password": "正しいパスワードを入力してください",
  "CONFIRM": "確認する",
  "TIX Balance": "TIX残高",
  "My Wallet": "私の財布",
  "SKAN QR": "QRをスキャン",
  "TIX Scan": "TIXスキャン",
  "TIX Market": "TIX市場",
  "Contact Support": "サポート問い合わせ先",
  "SETTINGS": "設定",
  "About TIX": "TIXについて",
  "Commission Fee": "手数料",
  "Add Store": "ストアを追加",
  "Add Notification": "通知を追加",
  "Coin": "コイン",
  "recoveryMessage": "回復メッセージ",
  "veryfyPhrase": "フレーズの検証",
  "1_4": "1_4",
  "5_8": "5_8",
  "9_12": "9_12",
  "Confirm": "確認する",
  "Wrong word": "間違った言葉",
  "Verify word": "単語を確認する",
  "Terms and Conditions": "利用規約",
  "I AGREE": "同意します",
  "smt_wrong": "smt_間違った",
  "Open Wallet": "オープンウォレット",
  "Create Wallet": "ウォレットの作成",
  "Create New Account": "新しいアカウントを作成する",
  "Import an Account": "アカウントをインポートする",
  "Import Wallet": "ウォレットをインポートする",
  "Watch Wallet": "ウォッチウォレット",
  "Enter Passphrase": "パスフレーズを入力してください",
  "word_1_24": "単語_1_24",
  "Next Step": "次のステップ",
  "Not Authorized": "許可されていません",
  "TIX WALLET": "ティックスウォレット",
  "Blockchain wallet": "ブロックチェーンウォレット",
  "Open wallet with fingerprint": "指紋で財布を開く",
  "Unlock with password": "パスワードでロックを解除する",
  "Contact and Support": "お問い合わせとサポート",
  "Balance": "バランス",
  "Send": "送信",
  "Total Balance": "総合収支",
  "Receive": "受け取る",
  "Passphrase": "パスフレーズ",
  "OK": "わかりました",
  "Press two times to Exit": "2 回押して終了します",
  "Receive Fund": "資金を受け取る",
  "YOUR TIX ADDRESS": "あなたのTIXアドレス",
  "TRANSFER FROM EXCHANGE": "取引所からの送金",
  "TRANSFER FROM WALLET": "ウォレットからの送金",
  "COPY ADDRESS": "アドレスをコピー",
  "YOUR TIX QR CODE ADDRESS": "あなたのTIX QRコードのアドレス",
  "SEND TO TIX WALLET": "TIXウォレットに送信",
  "SEND TO EXTERNAL WALLET": "外部ウォレットに送信",
  "commission_fee": "手数料",
  "Receiver address": "受信者のアドレス",
  "input receiving address": "受信アドレスを入力",
  "amount to send": "送金額",
  "input amount to send": "送金する金額を入力",
  "Sending fee": "送金手数料",
  "Copied": "コピーされました",
  "MAX TOTAL SUPPLY": "最大供給量",
  "Txn Hash": "トランザクションハッシュ",
  "Age": "年齢",
  "From": "から",
  "To": "まで",
  "Quantity": "数量",
  "No record founded": "記録が見つかりませんでした",
  "Select Coin": "コインを選択",
  "Save": "保存",
  "param_Balance": "パラメータバランス",
  "not_backed": "サポートされていません",
  "backup_msg": "バックアップメッセージ",
  "BACKUP": "バックアップ",
  "Remind me later": "後でリマインド",
  "PREFERENCES": "設定",
  "Language": "言語",
  "VIP Access": "VIPアクセス",
  "Pop-Up notifications": "ポップアップ通知",
  "SECURITY": "セキュリティ",
  "Market": "マーケット",
  "Earn": "稼ぐ",
  "Add Tokens": "トークンを追加",
  "Change password": "パスワードを変更",
  "Security mode": "モード",
  "Wallet": "ウォレット",
  "dApps": "dApps",
  "Unlock Wallet With": "ロックを解除する",
  "Auto-lock": "自動ロック",
  "GET IN TOUCH": "お問い合わせ",
  "Share this app": "このアプリを共有",
  "download_app": "アプリをダウンロード",
  "Review the App": "アプリをレビュー",
  "Join Telegram": "Telegramに参加",
  "Support Center": "サポートセンター",
  "Privacy Policy": "プライバシーポリシー",
  "App Version": "アプリのバージョン",
  "Fingerprint": "指紋",
  "Do not lock": "ロックなし",
  "Disabled": "無効",
  "Immediately": "即座に",
  "Setting": "設定",
  "1_min": "1分",
  "5_min": "5分",
  "30_min": "30分",
  "1_hour": "1時間",
  "5_hour": "5時間",
  "Have_you_paid": "支払いましたか",
  "Confirm_transaction": "トランザクションの確認",
  "Enter_Hash_key": "ハッシュキーを入力",
  "Hash_Key": "ハッシュキー",
  "RECEIVE TIX": "TIXを受け取る",
  "Send TIX": "TIXを送る",
  "SYSTEM": "システム",
  "Rank": "ランク",
  "Address": "アドレス",
  "Percentage": "パーセンテージ",
  "Info": "情報",
  "Overview": "概要",
  "Token Name": "トークン名",
  "Max Total Supply": "最大総供給量",
  "Holders": "ホルダー",
  "Transfers": "転送",
  "Contract": "契約",
  "Decimal": "小数点",
  "Website": "ウェブサイト",
  "NO TRANSACTION": "取引なし",
  "Backup Wallet": "ウォレットのバックアップ",
  "Select Password": "パスワードを選択",
  "New Wallet Password": "新しいウォレットのパスワード",
  "New password": "新しいパスワード",
  "Confirm Password": "パスワードを確認",
  "Change": "変更",
  "Use a minimum of 8 characters": "少なくとも8文字使用",
  "Use a minimum of 8 characters ✔": "少なくとも8文字使用 ✔",
  "Password does not matched": "パスワードが一致しません",
  "Password confirmed": "パスワードが確認されました",
  "Terms of Service": "利用規約",
  "PASTE": "貼り付け",
  "Transaction History": "取引履歴",
  "Filter": "フィルター",
  "Backup phrase": "バックアップフレーズ",
  "Backup Private Key": "バックアッププライベートキー",
  "Transaction": "取引",
  "Added": "追加されました",
  "Credit": "クレジット",
  "Debit": "デビット",
  "Trade Type:": "トレードタイプ：",
  "Credit:": "クレジット：",
  "Debit:": "デビット:",
  "From:": "から:",
  "To:": "まで:",
  "Hash:": "ハッシュ:",
  "RECEIVE FUNDS": "資金を受け取る",
  "Rate TIX Wallet": "TIXウォレットを評価する",
  "DEPOSIT": "デポジット",
  "Select Language": "言語を選択",
  "auth_message": "認証メッセージ",
  "Incorrect internal address": "内部アドレスが正しくありません",
  "Incorrect external address": "外部アドレスが正しくありません",
  "copied": "コピーされました",
  "Swap": "スワップ",
  "show": "表示",
  "Get Premium": "プレミアムを取得",
  "Join X": "Xに参加",
  "Receive List": "受信リスト",
  "Send List": "送信リスト",
  "Trade tokens in an instance": "インスタンスでトークンをトレード",
  "Enter amount": "金額を入力",
  "Price": "価格",
  "Welcome to Tixcash Wallet": "Tixcashウォレットへようこそ",
  "Your Digital passport": "あなたのデジタルパスポート",
  "Use this wallet to collect and other\napplications running on tixcash Wallet":
      "このウォレットを使用して、tixcash\n ウォレットで実行されている アプリケ\nーションを収集します",
  "Next": "次へ",
  "Allow us to track your data and\nhelp provide a better\nTixcash Wallet experience":
      "データの追跡を許可し、Tixcash ウォレットのエクスペリエンスを向上させてください",
  "We would like to collect data from your session to\nhelp make Tixcash Wallet easier and\nmore fun to use":
      "Tixcash Wallet を もっと簡単に、そしてもっと楽しく使えるようにするために、あなたのセッションからデータを収集したいと考えています。",
  "These data includes usage behavior such as clicking\nand scrolling as well as performance diagnostics.\nthey\'re totally anonymous and\nwill never be shared with anyone else":
      "これらのデータには クリックやスクロールなどの使用状況やパフォーマンス診断が含まれます。\nこれらは完全に匿名であり、他の人と共有されることはありません",
  "The home of your Funds & your\nNFT collection on TIXCASH Network":
      "TIXCASH ネットワーク上のファンドと\nNFT コレクションの本拠地",
  "Create new wallet": "新しいウォレットを作成",
  "I already have a wallet": "すでにウォレットを持っています",
  "On the next step, you will get the Secret Recovery Phrase (24 words), before that please read the following security tips":
      "次のステップでは、秘密の回復フレーズ（24単語）を取得します。それより前に、以下のセキュリティのヒントをお読みください",
  "If I lose my Secret Recovery Phrase, my assets will be gone":
      "秘密の回復フレーズを失った場合、資産はなくなります",
  "If I share my Secret Recovery Phrase with others, my assets will be stolen":
      "秘密の回復フレーズを他の人と共有すると、資産が盗まれます",
  "It is my responsibility to keep the Secret Recovery Phrase safe":
      "秘密の回復フレーズを安全に保つのは私の責任です",
  "Terms of use": "利用規約",
  "Generate Mnemonic": "ニーモニックを生成",
  "1 uppercase letter": "1つの大文字の文字",
  "1 lower letter": "1つの小文字の文字",
  "1 number": "1つの数字",
  "At least 8 characters": "少なくとも8文字",
  "Your recovery phrase consist of 24 words. It is used to restore your wallet":
      "あなたの回復フレーズは24語で構成されています。それはあなたのウォレットを復元するために使用されます",
  "Please Note Down Secret Recovery Phrase": "秘密の回復フレーズをメモしてください",
  "Remember :": "覚えておくこと：",
  "● Don\'t disclose secret recovery phrase to anyone Once the secret recovery phrase is lost, assets cannot be recovered":
      "● 秘密の回復フレーズを誰にも漏らさないでください。一旦秘密の回復フレーズが失われると、資産は回収できません",
  "● Please do not backup and save by screenshots or network transmission":
      "● スクリーンショットやネットワーク転送でのバックアップや保存はしないでください",
  "● Don't uninstall the app when in issues, note the recovery phrase first or contact us for help":
      "● 問題が発生した場合はアプリをアンインストールしないでください。まず回復フレーズをメモするか、ヘルプのためにお問い合わせください",
  "VERIFY NOW": "今すぐ確認",
  "Stake": "ステーク",
  "Referral": "紹介",
  "Tixcash Wallet": "Tixcashウォレット",
  "Enter 24 Word Secrate Phrase": "24単語の秘密フレーズを入力",
  "Enter & Select": "入力して選択",
  "Passphrase Entered (click to Edit)": "パスフレーズが入力されました（編集するにはクリック）",
  "Stack Amount": "スタック金額",
  "Enter the Amount": "金額を入力",
  "Available Balance :": "利用可能な残高：",
  "Duration": "期間",
  "Select Staking Plan": "ステーキングを選択",
  "Lock-in Amount limit": "ロックイン金額制限",
  "Min: No Limit": "最小：制限なし",
  "Max : No Limit": "最大: 制限なし",
  "Min : 500 TXH": "最大：制限なし",
  "Max : 50k TXH": "最大：50,000 TXH",
  "Date of Stake :": "ステーキング日：",
  "Start Date :": "開始日：",
  "End Date :": "終了日：",
  "Estimated APY :": "推定APY：",
  "Floating": "フローティング",
  "90 Days": "90日",
  "365 Days": "365日",
  "730 Days": "730日",
  "1460 Days": "1460日",
  "Whitelisted (Staking Period: 365 Days)": "ホワイトリスト入り（ステーキング期間：365日）",
  "About TIXCASH WALLET": "TIXCASH WALLETについて",
  "TIX WALLET VIP ACCESS": "TIXウォレットVIPアクセス",
  "Get more features": "さらなる機能を入手",
  "Multi-Wallet Access": "マルチウォレットアクセス",
  "Users can create multiple accounts and rename their accounts":
      "ユーザーは複数のアカウントを作成し、アカウントの名前を変更できます",
  "Stake & Earn": "ステークして稼ぐ",
  "Users have opportunity to earn more from their assets":
      "ユーザーは資産からさらに収益を得ることができます",
  "Refferral Reward": "紹介リワード",
  "Refer your friend & get reward on their\nstaking": "友達を紹介して、ステーキングで報酬を得る",
  "Select Premium Plan": "プレミアムプランを選択",
  "Select Currency": "通貨を選択",
  "General": "一般",
  "Language, Currency, Pop-up notification, Light & Dark Mode":
      "言語、通貨、ポップアップ通知、ライト&ダークモード",
  "Security & Privacy": "セキュリティとプライバシー",
  "Backup Phrase, Private Key, Change Password, Security Mode, Unlock Wallet With, Auto-Lock":
      "バックアップフレーズ、プライベートキー、パスワードの変更、セキュリティモード、ウォレットのロック解除、自動ロック",
  "Advanced": "高度",
  "Contact": "お問い合わせ",
  "Get In Touch": "連絡を取る",
  "Share This App, Review The App, Join Telegram, Support Center":
      "このアプリを共有する、アプリをレビューする、Telegramに参加する、サポートセンター",
  "About Section": "約セクション",
  "About Tixcash Wallet, Terms & Condition, Privacy Policy, App Version":
      "Tixcashウォレットについて、利用規約、プライバシーポリシー、アプリのバージョン",
  "Backup Phrase": "バックアップフレーズ",
  "Explorer": "冒険者",
  "DeFi": "DeFi",
  "NFTs": "NFT",
  "Assets": "資産",
  "Embark on your journey with Tixcash Wallet's revamped brand identity, tailored to enrich your Web3 experience. Uncover our intuitive layout and much more. Start your journey today":
      "Tixcash Walletの刷新されたブランドアイデンティティで旅を始め、Web3のエクスペリエンスを豊かにするように調整されました。直感的なレイアウトやその他多くの機能をご紹介します。今日から旅を始めましょう",
  "Tixcash Services": "サービス",
  "Tixcash Stake": "ステーク",
  "Fitness Club": "フィットネス",
  "Mining Pool": "マイニング",
  "Tixcash Stores": "ストア",
  "Courses": "コース",
  "Cash Sharing": "キャッシュ共有",
  "If I lose my Secret Recovery Phrase my assets will be gone":
      "秘密の回復フレーズを失うと私の資産は失われます",
  "If I share my Secret Recovery Phrase to others my assets will be stolen":
      "秘密の回復フレーズを他の人に共有すると、私の資産が盗まれます",
  "It is my responsibilities to keep the Secret Recovery Phrase safe":
      "秘密の回復フレーズを安全に保管するのは私の責任です",
  "Foundation": "財団",
  "Community": "コミュニティ",
  "With Tixcash Wallet, you can participate in Staking and the Referral Program, allowing you to increase your earnings while holding your assets":
      "Tixcash Walletを使用すると、ステーキングおよび紹介プログラムに参加して、資産を保持しながら収益を増やすことができます",
  "Refer & Earn": "紹介して稼ぐ",
  "Get VIP Access": "VIPアクセスを取得",
  "My Earnings": "私の収益",
  "My Sponsor Referral Code :": "私のスポンサー紹介コード：",
  "Staking Limit Left": "残りの限界",
  "All Stake\nValue": "すべての\n賭け金価値",
  "Total\nRewards": "合計\n報酬",
  "Pending\nRewards": "保留中の\n報酬",
  "Daily\nReward": "毎日の\n報酬",
  "Staking\nPeriod": "ステーキング\n間",
  "Staking Start Date": "ステーキング開始日",
  "Staking End Date": "ステーキング終了日",
  "Income Report": "収益レポート",
  "User Initiated Staking": "ステークを開始する",
  "Staked Amount": "賭け金額",
  "Total Staking Income": "ステーキング総収入",
  "Paid Days": "有給日数",
  "Unclaimed Income": "未請求の収入",
  "Claim Now": "今すぐ請求",
  "Days": "日",
  "Claim": "請求",
  "Max Total": "合計最大",
  "Network fee": "ネットワーク手数料",
  "Stake Income": "ステーキング収入",
  "Remark": "備考",
  "Amount :": "金額：",
  "Stake Claim": "ステーキング請求",
  "Refer Your Friends and Earn": "友達を紹介して稼ぐ",
  "About Referral": "紹介について",
  "History": "履歴",
  "Total Earning :": "総収益：",
  "Balance Amount :": "残高金額：",
  "No Stake": "ステークなし",
  "Transaction Date :": "取引日：",
  "Staking :": "ステーキング：",
  "Launching Soon": "近日公開",
  "You Are Premium Member": "あなたはプレミアムメンバーです",
  "The Market Page offers details and data about cryptocurrencies, including pricing, trade volumes, and market capitalization, gathered from a variety of well-known websites":
      "マーケットページでは、さまざまな有名なウェブサイトから収集された暗号通貨に関する詳細なデータやデータ、価格、取引量、時価総額などが提供されています",
  "Current Language": "現在の言語",
  "Translate the application to a different\nsupport language":
      "アプリケーションを別のサポート言語に翻訳します\n",
  "Currency": "通貨",
  "Username": "ユーザー名",
  "Select Recovery type": "回復タイプの選択",
  "Select Recover Account Type": "アカウントの回復タイプを選択",
  "Secret Phrase": "秘密のフレーズ",
  "Enter Private Key": "プライベートキーを入力",
  "Private Key": "プライベートキー",
  "@2023 Tixcash. All rights reserved": "@2023ティクキャッシュ。無断転載を禁じます",
  "Save it somewhere safe and secret": "安全で秘密の場所に保存してください",
  "Your private key": "あなたのプライベートキー",
  "Never disclose this key. Anyone with your private key can fully control your account, including transferring away any of your funds":
      "このキーを漏らさないでください。あなたのプライベートキーを持つ人は、あなたの資金を含むアカウントを完全に制御できます",
  "Share": "共有",
  "Done": "完了",
  "Copy": "コピー",
  "Code": "コード",
  "Share QR": "QRコードを共有",
  "Your Secret Recovery Phrase": "あなたの秘密の回復フレーズ",
  "Reset": "リセット",
  "Verify Account": "アカウントの確認",
  "The home of your Funds & your NFT collection on Tixcash Wallet Network":
      "Tixcash Wallet Network上の資金とNFTコレクションのホーム",
  "Enter Phrase": "フレーズを入力",
  "Linking to Tixcash Stake": "Tixcashステークへのリンク",
  "Sign": "署名",
  "Download the Tixcash Wallet app from play store\n\nhttps://play.google.com/store/apps/details?id=com.wallet.line":
      "PlayストアからTixcash Walletアプリをダウンロード\n\nhttps://play.google.com/store/apps/details?id=com.wallet.line",
  "Referral Claim History": "紹介請求履歴",
  "No Referral History": "紹介履歴なし",
  "1st gen referral income\" typically refers to the income or earnings that are directly generated from your direct referred user or downline members in a chain. These users are often referred to as your \"1st gen\" or \"first-level\" referrals. Your 1st gen income is the commission or bonus, you receive from the direct referrals you personally bring into the staking program.":
      "「第一世代紹介収入」とは、通常、チェーン内の直接紹介されたユーザーやダウンラインメンバーから直接発生する収入または利益を指します。これらのユーザーは通常、「第一世代」または「第一レベル」の紹介と呼ばれます。第一世代の収入は、あなたが個人的にステーキングプログラムに紹介した直接の紹介から受け取る手数料やボーナスです。",
  "What is 1st Gen Referral Income?": "第一世代紹介収入とは？",
  "What is 2nd Gen Referral Income?": "第二世代紹介収入とは？",
  "2nd gen referral income typically refers to earnings or income generated from referrals made by individuals who were directly referred by you. In the context of referral or affiliate programs, when you refer someone (1st gen), and they, in turn, refer others (2nd gen), the income you receive from the activities of those 2nd Gen referrals can be considered your 2nd gen referral income.":
      "「第二世代紹介収入」とは、通常、あなたが直接紹介した個人による紹介から生じる収益または収入を指します。紹介プログラムまたは提携プログラムの文脈では、誰かを紹介すると（第一世代）、そして彼らが他を紹介すると（第二世代）、その第二世代の紹介の活動から受け取る収入は、第二世代の紹介収入と見なすことができます。",
  "Referral Income": "紹介収入",
  "1st Gen Referral Income": "第一世代紹介収入",
  "2nd Gen Referral Income": "第二世代紹介収入",
  "Note :": "注意：",
  "All above have Min 500 TXH to max. 50000 TXH stake amount limitations.":
      "上記すべてには、最小500 TXHから最大50000 TXHのステーク金額の制限があります。",
  "Whitelisted stake : ": "ホワイトリストのステーク：",
  "(only available for a Whitelisted\n users)": "（ホワイトリストのユーザーのみ利用可能）",
  "Whitelisted (365)": "ホワイトリスト（365）",
  "No stake amount limitations": "ステーク金額の制限なし",
  "You have Insufficient balance": "残高が不足しています",
  "You have either insufficient balance or gas fee": "残高またはガス料金が不足しています",
  "Claim Successfully": "請求が成功しました",
  "Select Stake Plan": "ステークプランを選択",
  "YYYY : MM : DD": "年 : 月 : 日",
  "You Are Not Whitelisted Member": "あなたはホワイトリストに登録されていません",
  "Whitelisted (Staking Period:- 365 Days)": "ホワイトリスト（ステーキング期間：- 365日）",
  "Enter Referral Code (Optional)": "紹介コードを入力してください（オプション）",
  "Tixcash vip access": "Tixcash VIPアクセス",
  "Skip Referral Code": "紹介コードをスキップ",
  "** ⚠️ Warning ⚠️ ": " ⚠️ 警告 ⚠️ **",
  "Referral code is important and permanent. If missed then the referral rewards will be missed.":
      "紹介コードは重要で永続的です。逃した場合、紹介の報酬も逃します。",
  "Okay": "はい",
  "Get Access": "アクセス取得",
  "Subscription Successfully": "正常に購読されました",
  "Try after some time": "しばらくしてから試してください",
  "Gas fee :": "ガス料金：",
  "Status :": "ステータス：",
  "Staking": "ステーキング",
  "TXT hash :": "TXタッシュ:",
  "Claim Referral INCOME": "紹介収入を請求",
  "Approved": "承認済み",
  "Please Enter Balance": "残高を入力してください",
  "Please Select Staking Plan": "ステーキングプランを選択してください",
  "Please Enter Balance Less than 50000 TXH": "50000 TXH未満の残高を入力してください",
  "Please Enter Balance More than 500 TXH": "500 TXH以上の残高を入力してください",
  "Staking History": "ステーキング履歴",
  "No Stake History": "ステーキング履歴なし",
  "Address Copied": "アドレスがコピーされました",
  "Withdrawal Successful": "引き出しが成功しました",
  "Will be confirmed in 16 confirmations": "16回の確認で確定されます",
  "Join Twitter": "Twitterに参加",
  "Join Facebook": "Facebookに参加",
  "Join Github": "Githubに参加",
  "Succeed": "成功",
  "Password changed successfully": "パスワードが正常に変更されました",
  "Are You Sure\nYou Want To Erase Your\nWallet?": "本当に\nウォレットを消去しますか？",
  "Your current wallet, accounts, and assets will be removed from this app permanently. This action cannot be undone.":
      "現在のウォレット、アカウント、および資産は永久にこのアプリから削除されます。この操作は元に戻せません。",
  "You can ONLY recover this wallet with your Secret Recovery Phrase. TIXCASH WALLET does not have your Secret Recovery Phrase.":
      "このウォレットは秘密の回復フレーズでのみ回復できます。Tixcashウォレットにはあなたの秘密の回復フレーズはありません。",
  "I understand, continue": "了解しました、続行します",
  "Import From Gallery": "ギャラリーからインポート",
  "Unlimited": "制限なし",
  "Claim Staking Reward": "ステーキング報酬の請求",
  "Transaction Details": "取引の詳細",
  "View on Tixcash": "Tixcashで表示",
  "Sending account": "送信アカウント",
  "Receiving account": "受信アカウント",
  "Transaction Type": "取引の種類",
  "Transaction Hash": "取引ハッシュ",
  "Date": "日付",
  "Sent": "送信済み",
  "Received": "受信済み",
  "Send To Tixcash Wallet": "Tixcashウォレットに送信",
  "RECEIVE": "受け取る",
  "YOUR": "あなたの",
  "QR CODE ADDRESS": "QRコードアドレス",
  "ADDRESS": "住所",
  "About Tixcash Wallet": "Tixcashウォレットについて",
  "My Referral": "私の紹介",
  "1st Gen Referral": "第1世代の紹介",
  "2nd Gen Referral": "第2世代の紹介",
  "Backup your phrase first": "まずフレーズをバックアップしてください",
  "Invalid address": "無効なアドレス",
  "Estimated Gas Fee": "見積もりガス手数料",
  "Official Tixcash preorder and purchase channel": "公式Tixcash事前注文および購入チャンネル",
  "Only USDC and BUSD of BEP20 accepted.": "BEP20のUSDCおよびBUSDのみ受け付けています",
  "Bad (Internet) Connection": "(インターネット)接続が悪い",
  "Error": "エラー",
  "Something went wrong, try again": "何か問題が発生しました。もう一度やり直してください",
  "Year Access": "年間アクセス",
  "Years Access": "年間アクセス",
  "Are you sure want to delete your account?\nHave you taken your backup?":
      "アカウントを削除してもよろしいですか？\nバックアップを取りましたか？",
  "Delete Account": "アカウントを削除",
  "Delete": "削除",
  "null": "なし",
  "Failed": "失敗",
  "Wrong Phrase Key": "誤ったフレーズキー",
  "Enter Name": "名前を入力",
  "Enter Address": "住所を入力してください",
  "Address Deleted": "アドレスが削除されました",
  "Wallet Address": "ウォレットアドレス",
  "Update": "アップデート",
  "Address Book": "住所録",
  "Save Your Name & Address & NetWork": "名前、住所、ネットワークを保存",
};
