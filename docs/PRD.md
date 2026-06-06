# TestMate — PRD v1

## 需求概述
TestMate 是基于 Maestro 框架的移动应用 E2E 测试平台，提供 YAML 测试流编写、行业模板库、Android 模拟器运行和 CI/CD 集成能力。

## 验收标准 (AC)
- AC-1: Maestro CLI 本地安装 + 版本验证
- AC-5: YAML 测试流编写 + Android 模拟器运行
- AC-7: 行业模板库开发（电商/社交/金融 3 套基础模板）+ CI/CD 集成（GitHub Actions/GitLab CI 插件）

## 测试场景

### 场景 1：电商 App 登录流程测试
1. 运行 templates/ecommerce/login-flow.yaml
2. 验证登录按钮可点击
3. 输入测试账号并验证跳转

### 场景 2：CI 集成验证
1. 推送代码到 main 分支
2. GitHub Actions 自动触发 Maestro 测试
3. 测试报告上传为 artifact
