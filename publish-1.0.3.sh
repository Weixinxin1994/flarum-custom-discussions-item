#!/bin/bash

# 发布1.0.3版本脚本
echo "🚀 开始发布1.0.3版本..."

# 检查是否在正确的目录
if [ ! -f "composer.json" ]; then
    echo "❌ 错误: 请在扩展根目录运行此脚本"
    exit 1
fi

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
    git commit -m "Release version 1.0.3 - Performance improvements and bug fixes"
    
    # 创建标签
    echo "🏷️  创建Git标签 v1.0.3..."
    git tag -a "v1.0.3" -m "Release version 1.0.3 - Performance improvements and bug fixes"
    
    # 推送到远程仓库
    echo "📤 推送到远程仓库..."
    git push origin main
    git push origin "v1.0.3"
    
    echo "✅ 代码已推送到GitHub"
    echo "🏷️  标签 v1.0.3 已创建"
    
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
echo "🎉 1.0.3版本发布完成！"
echo ""
echo "📋 版本信息:"
echo "- 版本号: 1.0.3"
echo "- 包名: weixinxin1994/flarum-custom-discussions-item"
echo "- 描述: Performance improvements and bug fixes"
echo ""
echo "🔗 相关链接:"
echo "- GitHub仓库: https://github.com/Weixinxin1994/flarum-custom-discussions-item"
echo "- Packagist: https://packagist.org/packages/weixinxin1994/flarum-custom-discussions-item"
echo ""
echo "🧪 测试安装命令:"
echo "composer require weixinxin1994/flarum-custom-discussions-item:1.0.3"
