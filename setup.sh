# .devcontainerディレクトリとファイル作成
mkdir -p .devcontainer
cat << 'EOF' > .devcontainer/Dockerfile
# Hugo Extended版イメージ（Alpineベース）を利用
FROM klakegg/hugo:ext-alpine

# 作業ディレクトリを設定
WORKDIR /workspace

# 必要に応じて追加のツールをインストール（例: Node.js）
# RUN apk add --no-cache nodejs npm
EOF

cat << 'EOF' > .devcontainer/devcontainer.json
{
  "name": "Hugo Portfolio",
  "build": {
    "dockerfile": "Dockerfile",
    "context": ".."
  },
  "settings": {
    "terminal.integrated.shell.linux": "/bin/bash"
  },
  "extensions": [
    "ms-azuretools.vscode-docker",
    "shd101wyy.markdown-preview-enhanced"
  ],
  "forwardPorts": [
    1313
  ],
  "postCreateCommand": "hugo version",
  "remoteUser": "root"
}
EOF

# archetypesディレクトリとテンプレートファイル作成
mkdir -p archetypes
cat << 'EOF' > archetypes/default.md
---
title: "{{ replace .Name "-" " " | title }}"
date: {{ .Date }}
draft: true
---
EOF

cat << 'EOF' > archetypes/article.md
---
title: "New Article: {{ replace .Name "-" " " | title }}"
date: {{ .Date }}
draft: true
categories: ["article"]
tags: []
titleImage: ""
---
EOF

cat << 'EOF' > archetypes/achievement.md
---
title: "New Achievement: {{ replace .Name "-" " " | title }}"
date: {{ .Date }}
draft: true
categories: ["achievement"]
tags: []
titleImage: ""
---
EOF

cat << 'EOF' > archetypes/project.md
---
title: "New Project: {{ replace .Name "-" " " | title }}"
date: {{ .Date }}
draft: true
categories: ["project"]
tags: []
titleImage: ""
EOF

# contentディレクトリと各サブディレクトリ・ファイル作成
mkdir -p content/articles content/achievements content/projects

cat << 'EOF' > content/_index.md
---
title: "トップページ"
description: "自己紹介や最新のコンテンツを表示するトップページ"
---
# ようこそ！

ここに自己紹介や所属、技術スタックなどを記述してください。
EOF

cat << 'EOF' > content/articles/sample-article.md
---
title: "サンプル記事"
date: 2025-04-03
draft: false
titleImage: "/images/sample.jpg"
---
この記事はサンプル記事です。内容を自由に編集してください。
EOF

cat << 'EOF' > content/achievements/sample-achievement.md
---
title: "サンプル実績"
date: 2025-04-03
draft: false
titleImage: "/images/sample.jpg"
---
こちらはサンプル実績の説明です。詳細を記述してください。
EOF

cat << 'EOF' > content/projects/sample-project.md
---
title: "サンプル制作物"
date: 2025-04-03
draft: false
titleImage: "/images/sample.jpg"
---
こちらはサンプル制作物の詳細情報です。制作日時やリンクなどを記述してください。
EOF

# layoutsディレクトリとテンプレート作成
mkdir -p layouts/partials layouts/_default

cat << 'EOF' > layouts/partials/header.html
<header>
  <h1>ポートフォリオサイト</h1>
  <nav>
    <ul>
      <li><a href="https://twitter.com/your_twitter">Twitter</a></li>
      <li><a href="https://github.com/your_github">Github</a></li>
      <li><a href="/articles/">記事</a></li>
      <li><a href="/achievements/">実績</a></li>
      <li><a href="/projects/">制作物</a></li>
    </ul>
  </nav>
</header>
EOF

cat << 'EOF' > layouts/partials/sidebar.html
<aside>
  <h2>サイドバー</h2>
  <p>プロフィール概要などを記述</p>
</aside>
EOF

cat << 'EOF' > layouts/partials/footer.html
<footer>
  <p>&copy; 2025 あなたの名前. All rights reserved.</p>
</footer>
EOF

cat << 'EOF' > layouts/_default/baseof.html
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>{{ .Title }}</title>
  <link rel="stylesheet" href="/css/styles.css">
</head>
<body>
  {{ partial "header.html" . }}
  <div class="container">
    {{ partial "sidebar.html" . }}
    <main>
      {{ block "main" . }}{{ end }}
    </main>
  </div>
  {{ partial "footer.html" . }}
  <script src="/js/main.js"></script>
</body>
</html>
EOF

cat << 'EOF' > layouts/_default/list.html
{{ define "main" }}
  <h1>{{ .Title }}</h1>
  <ul>
    {{ range .Pages }}
      <li>
        <a href="{{ .Permalink }}">{{ .Title }}</a>
      </li>
    {{ end }}
  </ul>
{{ end }}
EOF

cat << 'EOF' > layouts/_default/single.html
{{ define "main" }}
  <article>
    <h1>{{ .Title }}</h1>
    {{ if .Params.titleImage }}
      <img src="{{ .Params.titleImage }}" alt="{{ .Title }}">
    {{ end }}
    {{ .Content }}
  </article>
{{ end }}
EOF

# staticディレクトリとサブディレクトリ・サンプルファイル作成
mkdir -p static/css static/js static/images

cat << 'EOF' > static/css/styles.css
/* サンプルスタイル */
body {
  font-family: sans-serif;
  margin: 0;
  padding: 0;
}
.container {
  display: flex;
}
main {
  flex: 1;
  padding: 1rem;
}
EOF

cat << 'EOF' > static/js/main.js
// サンプルJavaScript
console.log("Portfolio site loaded.");
EOF

cat << 'EOF' > static/images/sample.jpg
[サンプル画像ファイル。実際は画像ファイルを配置してください]
EOF

# テーマディレクトリ（任意）とREADME作成
mkdir -p themes
cat << 'EOF' > README.md
# ポートフォリオサイト

このプロジェクトは Hugo を利用したポートフォリオサイトです。
詳細は各ディレクトリ内の README などを参照してください。
EOF

# config.tomlの作成（基本設定例）
cat << 'EOF' > config.toml
baseURL = "http://localhost:1313"
languageCode = "ja"
title = "ポートフォリオサイト"
theme = ""
[params]
  author = "あなたの名前"
EOF

echo "ディレクトリとファイルの作成が完了しました。"
