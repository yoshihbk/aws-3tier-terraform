# AWS 3-Tier Architecture（構成意図）

このプロジェクトは、AWS 上に 3-Tier 構成の Web アプリケーション基盤を  
Terraform によって IaC として再現可能にすることを目的としています。

---

## 1. 全体構成と責任境界

### Web Tier（Public Subnet）
- 外部公開が必要なリソースのみ配置  
- ALB と Web EC2 が担当  
- インターネットからの入口となる層  
- App Tier への通信のみ許可する責任境界

### App Tier（Private Subnet）
- アプリケーション層（ビジネスロジック）を実行する層  
- 外部公開されず、Web Tier からの通信のみ受け付ける  
- DB にアクセスできる唯一の層  
- 内部処理の責任境界として機能し、セキュリティの中心となる

### DB Tier（Private Subnet）
- データ永続化を担当  
- RDS Multi-AZ により高可用性を確保  
- App Tier からの通信のみ許可する責任境界

---

## 2. 通信フロー

1. ユーザー → ALB（Public）  
2. ALB → Web Tier（EC2）  
3. Web Tier → App Tier（EC2 Private）  
4. App Tier → RDS（Private）  
5. App Tier → NAT Gateway（外部 API 通信）

---

## 3. 技術選定理由

### なぜ 3-Tier なのか？
- Web / App / DB の責任境界を明確に分離できる  
- スケール戦略が取りやすい  
- セキュリティ境界が明確  
- 実務で最も採用される構成

### なぜ ALB なのか？
- L7 レベルでのルーティングが可能  
- Auto Scaling Group と連携しやすい  
- HTTPS 終端を集約できる

### なぜ NAT Gateway なのか？
- Private Subnet の EC2 が外部 API にアクセスするため  
- NAT インスタンスより高可用性・低運用コスト

### なぜ RDS Multi-AZ なのか？
- DB の可用性を確保  
- AZ 障害時も自動フェイルオーバー  
- 運用負荷を最小化

### なぜ Terraform なのか？
- IaC による再現性  
- バージョン管理が可能  
- 手作業の構築ミスを防げる  
- 実務での標準ツール

---

## 4. この構成で得られるメリット

- 高可用性（Multi-AZ / ALB / ASG）  
- セキュアなネットワーク分離（Public / Private）  
- スケーラブル（Web Tier のみスケールアウト可能）  
- IaC による再現性と管理性の向上  
- 実務に近い構成での学習効果

---

## 5. Architecture Diagram

README.md に掲載した図を参照。