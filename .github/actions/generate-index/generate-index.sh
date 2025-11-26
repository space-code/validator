#!/bin/bash
set -e

# Get environment variables
CURRENT_VERSION="${VERSION}"
PROJECT_NAME="${PROJECT_NAME}"
PROJECT_DESC="${PROJECT_DESC}"
MODULES_JSON="${MODULES}"

echo "🔧 Generating DocC index page..."
echo "  Version: $CURRENT_VERSION"
echo "  Project: $PROJECT_NAME"

# Create docs directory if it doesn't exist
mkdir -p docs

# Generate module cards HTML
generate_module_cards() {
    if [ "$MODULES_JSON" = "[]" ] || [ -z "$MODULES_JSON" ]; then
        echo "⚠️  No modules provided"
        cat << 'EOF'
<div style="text-align: center; padding: 60px 20px; color: #6e6e73;">
    <p style="font-size: 21px; margin-bottom: 12px;">No documentation modules available</p>
    <p style="font-size: 17px;">Please configure modules in the action inputs</p>
</div>
EOF
        return
    fi

    python3 << 'PYTHON_SCRIPT'
import json
import sys
import os

modules_json = os.environ.get('MODULES_JSON', '[]')
current_version = os.environ.get('CURRENT_VERSION', '')

try:
    modules = json.loads(modules_json)
    if not modules:
        sys.exit(0)
    
    for m in modules:
        name = m.get('name', '')
        path = m.get('path', '')
        description = m.get('description', '')
        badge = m.get('badge', 'Module')
        
        card_html = f'''<a href="{current_version}/{name}/documentation/{path}" class="doc-card">
    <span class="module-badge">{badge}</span>
    <h2>{name}</h2>
    <p>{description}</p>
    <span class="link">View documentation</span>
</a>
'''
        print(card_html)
        
except json.JSONDecodeError as e:
    print(f"Error: Invalid JSON format: {e}", file=sys.stderr)
    sys.exit(1)
except Exception as e:
    print(f"Error: {e}", file=sys.stderr)
    sys.exit(1)
PYTHON_SCRIPT
}

# Export variables for Python script
export MODULES_JSON
export CURRENT_VERSION

# Generate module cards
MODULE_CARDS=$(generate_module_cards)

# Create the HTML file
cat > docs/index.html << EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${PROJECT_NAME} Documentation</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: -apple-system, BlinkMacSystemFont, "SF Pro Display", "Segoe UI", Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
            background: #f5f5f7;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 20px;
            color: #1d1d1f;
        }
        .container {
            max-width: 980px;
            width: 100%;
        }
        header {
            text-align: center;
            margin-bottom: 60px;
        }
        h1 {
            font-size: 56px;
            font-weight: 600;
            letter-spacing: -0.005em;
            line-height: 1.07143;
            margin-bottom: 8px;
            color: #1d1d1f;
        }
        .subtitle {
            font-size: 28px;
            font-weight: 400;
            line-height: 1.14286;
            color: #6e6e73;
        }
        .version-badge {
            display: inline-block;
            background: #0071e3;
            color: white;
            padding: 6px 14px;
            border-radius: 16px;
            font-size: 14px;
            font-weight: 600;
            margin-top: 12px;
        }
        .docs-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
            gap: 24px;
            margin-bottom: 40px;
        }
        .doc-card {
            background: white;
            border-radius: 18px;
            padding: 40px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            text-decoration: none;
            display: block;
            border: 1px solid rgba(0,0,0,0.06);
        }
        .doc-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 24px rgba(0,0,0,0.12);
        }
        .doc-card h2 {
            font-size: 32px;
            font-weight: 600;
            margin-bottom: 12px;
            color: #1d1d1f;
            letter-spacing: -0.003em;
        }
        .doc-card p {
            font-size: 17px;
            line-height: 1.47059;
            color: #6e6e73;
            margin-bottom: 20px;
        }
        .doc-card .link {
            font-size: 17px;
            color: #0071e3;
            font-weight: 400;
            display: inline-flex;
            align-items: center;
        }
        .doc-card .link::after {
            content: '→';
            margin-left: 8px;
            transition: transform 0.3s ease;
        }
        .doc-card:hover .link::after {
            transform: translateX(4px);
        }
        .module-badge {
            display: inline-block;
            background: #f5f5f7;
            color: #6e6e73;
            padding: 4px 12px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 600;
            letter-spacing: 0.5px;
            text-transform: uppercase;
            margin-bottom: 16px;
        }
        footer {
            text-align: center;
            padding-top: 40px;
            border-top: 1px solid rgba(0,0,0,0.08);
            margin-top: 40px;
        }
        footer p {
            font-size: 14px;
            color: #86868b;
        }
        @media (max-width: 768px) {
            h1 {
                font-size: 40px;
            }
            .subtitle {
                font-size: 21px;
            }
            .docs-grid {
                grid-template-columns: 1fr;
            }
            .doc-card {
                padding: 32px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>${PROJECT_NAME}</h1>
            <p class="subtitle">${PROJECT_DESC}</p>
            <span class="version-badge">${CURRENT_VERSION}</span>
        </header>
        
        <div class="docs-grid">
            ${MODULE_CARDS}
        </div>
        
        <footer>
            <p>Generated with Swift DocC</p>
        </footer>
    </div>
</body>
</html>
EOF

echo "✅ Index page created successfully at docs/index.html"
echo "  📦 Modules: $(echo "$MODULES_JSON" | python3 -c "import sys, json; data=json.load(sys.stdin); print(len(data)) if isinstance(data, list) else print(0)")"