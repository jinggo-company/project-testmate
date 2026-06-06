# ARCHITECTURE.md — TestMate 架构设计

## 模块概览

```
┌─────────────────────────────────────────────────────┐
│                    TestMate Platform                 │
├─────────────┬───────────────┬───────────────────────┤
│  CLI Layer  │  Flow Engine  │  Template Library     │
│             │               │                       │
│ • maestro   │ • YAML parser │ • ecommerce/          │
│   commands  │ • command     │ • social/             │
│ • studio UI │   executor    │ • finance/            │
│ • version   │ • retry logic │ • custom template API │
│   manager   │ • assertions  │                       │
├─────────────┴───────────────┴───────────────────────┤
│                   Infrastructure                     │
├─────────────┬───────────────┬───────────────────────┤
│   Android   │    CI/CD      │   Reporting           │
│   Emulator  │   Pipeline    │                       │
│             │               │ • JUnit XML output    │
│ • API 33    │ • GitHub      │ • HTML report         │
│ • headless  │   Actions     │ • screenshot capture  │
│   mode      │ • GitLab CI   │ • video recording     │
└─────────────┴───────────────┴───────────────────────┘
```

## 代码架构

### 目录结构

```
project-testmate/
├── README.md
├── docs/
│   ├── TECH_STACK.md
│   ├── ARCHITECTURE.md
│   └── TEST_CASES.md
├── scripts/
│   ├── install-maestro.sh      # Maestro 安装脚本
│   ├── setup-emulator.sh       # Android 模拟器配置
│   ├── run-tests.sh            # 测试执行入口
│   └── verify-deployment.sh    # 部署验证
├── flows/
│   └── sample-flow.yaml        # 示例测试流
├── templates/
│   ├── ecommerce/              # 电商模板
│   │   ├── login-flow.yaml
│   │   ├── checkout-flow.yaml
│   │   └── search-flow.yaml
│   ├── social/                 # 社交模板
│   │   ├── register-flow.yaml
│   │   ├── post-flow.yaml
│   │   └── interact-flow.yaml
│   └── finance/                # 金融模板
│       ├── login-flow.yaml
│       ├── transfer-flow.yaml
│       └── statement-flow.yaml
├── ci/
│   ├── github-actions.yml      # GitHub Actions 配置
│   └── gitlab-ci.yml           # GitLab CI 配置
└── reports/                    # 测试报告输出
```

### 关键接口

#### 1. Maestro CLI 封装

```bash
# 安装
maestro --version

# 运行单个测试流
maestro test <flow.yaml> [--device=<device-id>]

# 运行测试套件
maestro test flows/ --format=junit

# 启动 Studio（交互式录制）
maestro studio
```

#### 2. 测试流格式 (YAML)

```yaml
appId: com.example.app
---
- launchApp
- tapOn: "登录"
- inputText: "testuser"
- tapOn: "密码输入框"
- inputText: "password123"
- tapOn: "登录按钮"
- assertVisible: "欢迎"
```

#### 3. 模板加载机制

```
templates/
  └── <category>/
      └── <flow>.yaml

# 通过环境变量注入目标 App ID
MAESTRO_APP_ID=com.target.app maestro test templates/ecommerce/login-flow.yaml
```

## PRD AC 映射

| AC | 架构覆盖 | 实现位置 |
|----|----------|----------|
| AC-1 | Maestro CLI 安装 + 版本验证 | scripts/install-maestro.sh |
| AC-5 | YAML 测试流 + 模拟器运行 | flows/, scripts/run-tests.sh |
| AC-7 | 行业模板库 + CI/CD | templates/, ci/ |
