# project-testmate

> TestMate — 面向中国移动开发团队的企业级 E2E 测试平台（基于 Maestro）

## 状态
- **Phase:** `dev`
- **Project ID:** P-2026-00027
- **Gate:** G-2026-00079
- **Lead Dev:** quanchen

## 概述
TestMate 是基于 Maestro 的企业级 E2E 测试平台，提供：
- Maestro CLI 本地安装与版本管理
- YAML 测试流编写与 Android 模拟器运行
- 行业模板库（电商/社交/金融）
- CI/CD 集成（GitHub Actions / GitLab CI）

## 本地运行

### 前置条件
- Java 11+（Maestro 依赖）
- Android SDK / Android Emulator
- Docker（可选，用于 CI 环境）

### 安装 Maestro
```bash
./scripts/install-maestro.sh
```

### 运行测试
```bash
./scripts/run-tests.sh
```

### 运行模板测试
```bash
maestro test templates/ecommerce/login-flow.yaml
maestro test templates/social/post-flow.yaml
maestro test templates/finance/transfer-flow.yaml
```

## 项目结构
```
project-testmate/
├── README.md
├── docs/
│   ├── TECH_STACK.md
│   ├── ARCHITECTURE.md
│   └── TEST_CASES.md
├── scripts/
│   ├── install-maestro.sh
│   ├── setup-emulator.sh
│   ├── run-tests.sh
│   └── verify-deployment.sh
├── flows/
│   └── sample-flow.yaml
├── templates/
│   ├── ecommerce/
│   ├── social/
│   └── finance/
└── ci/
    ├── github-actions.yml
    └── gitlab-ci.yml
```

## 任务记录
- T-2026-00197: 技术架构设计 (done)
- T-2026-00206: Maestro 核心部署 + Android 模拟器 E2E 验证 (in_progress)
