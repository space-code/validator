#!/bin/bash

set -e

echo "🔧 Installing git hooks..."

# Find git repository root
GIT_ROOT=$(git rev-parse --show-toplevel 2>/dev/null)

if [ -z "$GIT_ROOT" ]; then
    echo "❌ Error: Not a git repository"
    exit 1
fi

echo "📁 Git root: $GIT_ROOT"

# Create hooks directory if it doesn't exist
mkdir -p "$GIT_ROOT/.git/hooks"

# Create pre-commit hook
cat > "$GIT_ROOT/.git/hooks/pre-commit" <<'HOOK_EOF'
#!/bin/bash

echo "🔍 Running linters..."

echo "📝 Formatting staged Swift files..."
git diff --diff-filter=d --staged --name-only | grep -e '\.swift$' | while read line; do
  if [[ $line == *"/Generated"* ]]; then
    echo "⏭️  Skipping generated file: $line"
  else
    echo "✨ Formatting: $line"
    mise exec swiftformat -- swiftformat "${line}"
    git add "$line"
  fi
done

if ! mise run lint; then
    echo "❌ Lint failed. Please fix the issues before committing."
    echo "💡 Tip: Run 'mise run format' to auto-fix some issues"
    echo "⚠️  To skip this hook, use: git commit --no-verify"
    exit 1
fi

echo "✅ All checks passed!"
exit 0
HOOK_EOF

chmod +x "$GIT_ROOT/.git/hooks/pre-commit"

echo "✅ Git hooks installed successfully!"
echo "📍 Hook location: $GIT_ROOT/.git/hooks/pre-commit"
echo ""
echo "Pre-commit hook will:"
echo "  1. Format staged Swift files (except /Generated)"
echo "  2. Run mise lint"
echo ""
echo "To skip the hook, use: git commit --no-verify"