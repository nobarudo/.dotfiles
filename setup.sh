OS_NAME=$(uname)
if [ "$OS_NAME" = "Darwin" ]; then
  echo "🍎 Mac環境を検知しました"
  TARGET="nobarudo"
elif [ "$OS_NAME" = "Linux" ]; then
  echo "🐧 Linux (WSL等) 環境を検知しました"
  TARGET="nobarudo-wsl"
else
  echo "❌ 未対応のOSです: $OS_NAME"
  exit 1
fi

# 4. バックアップオプション付きで安全に実行
# （Zshのエラーを防ぐためダブルクォーテーションで囲んでいます）
home-manager switch -b backup --flake ".#${TARGET}"
