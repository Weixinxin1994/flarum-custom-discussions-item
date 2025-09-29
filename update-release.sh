#!/bin/bash

# Flarum扩展更新发布脚本
# 使用方法: ./update-release.sh [版本号] [提交信息]

# 设置默认值
VERSION=${1:-"1.0.1"}
COMMIT_MSG=${2:-"Update to version $VERSION"}

echo "🚀 开始更新发布流程..."
echo "📦 版本号: $VERSION"
echo "💬 提交信息: $COMMIT_MSG"

# 检查是否在正确的目录
if [ ! -f "composer.json" ]; then
    echo "❌ 错误: 请在扩展根目录运行此脚本"
    exit 1
fi

# 更新版本号
echo "📝 更新版本号到 $VERSION..."

# 更新composer.json中的版本号
sed -i.bak "s/\"version\": \"[^\"]*\"/\"version\": \"$VERSION\"/" composer.json

# 更新package.json中的版本号
if [ -f "js/package.json" ]; then
    sed -i.bak "s/\"version\": \"[^\"]*\"/\"version\": \"$VERSION\"/" js/package.json
fi

# 更新README.md中的版本信息
if [ -f "README.md" ]; then
    sed -i.bak "s/### v[0-9]\+\.[0-9]\+\.[0-9]\+/### v$VERSION/" README.md
fi

# 清理备份文件
rm -f *.bak js/*.bak

echo "✅ 版本号更新完成"

# 检查Git状态
echo "🔍 检查Git状态..."
if [ -n "$(git status --porcelain)" ]; then
    echo "📋 发现以下更改:"
    git status --short
    
    # 添加所有更改
    echo "➕ 添加所有更改到Git..."
    git add .
    
    # 提交更改
    echo "💾 提交更改..."
    git commit -m "$COMMIT_MSG"
    
    # 创建标签
    echo "🏷️  创建Git标签 v$VERSION..."
    git tag -a "v$VERSION" -m "Release version $VERSION"
    
    # 推送到远程仓库
    echo "📤 推送到远程仓库..."
    git push origin main
    git push origin "v$VERSION"
    
    echo "✅ 代码已推送到GitHub"
    echo "🏷️  标签 v$VERSION 已创建"
    
else
    echo "ℹ️  没有发现更改，跳过提交"
fi

# 验证composer.json
echo "🔍 验证composer.json..."
if composer validate; then
    echo "✅ composer.json 验证通过"
else
    echo "❌ composer.json 验证失败"
    exit 1
fi

echo ""
echo "🎉 更新发布流程完成！"
echo ""
echo "📋 下一步操作:"
echo "1. 检查Packagist是否自动检测到新版本"
echo "2. 如果没有自动更新，手动触发Packagist更新"
echo "3. 测试新版本安装: composer require weixinxin1994/flarum-custom-discussions-item:$VERSION"
echo ""
echo "🔗 相关链接:"
echo "- GitHub仓库: https://github.com/Weixinxin1994/flarum-custom-discussions-item"
echo "- Packagist: https://packagist.org/packages/weixinxin1994/flarum-custom-discussions-item"
