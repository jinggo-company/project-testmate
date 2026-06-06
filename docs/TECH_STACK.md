# TECH_STACK.md — TestMate 技术栈

## 核心技术

| 组件 | 版本 | 说明 |
|------|------|------|
| Maestro | 1.39+ | 移动端 E2E 测试框架（核心） |
| Java | 11+ | Maestro 运行时依赖 |
| Android SDK | API 33+ | Android 模拟器运行环境 |
| Android Emulator | API 33 (Google Play) | E2E 测试目标设备 |
| Node.js | 20.x | 工具链与脚本 |
| Docker | 24+ | CI 环境容器化 |

## Maestro CLI

- 安装方式: Homebrew (macOS) / 手动安装 (Linux)
- 命令: `maestro test <flow.yaml>`, `maestro studio`
- 配置文件: `~/.maestro/config.yaml`

## 测试流格式

- YAML 格式
- 支持: `launchApp`, `tapOn`, `inputText`, `assertVisible`, `scroll`, `takeScreenshot`, `runFlow`
- 环境变量: `${MAESTRO_ANDROID_SDK_PATH}`, `${MAESTRO_DEVICE}`

## 行业模板库

- **电商模板**: 登录 → 搜索 → 加购 → 结算流程
- **社交模板**: 注册 → 发布 → 互动流程
- **金融模板**: 登录 → 转账 → 查询流水

## CI/CD 集成

### GitHub Actions
- 使用 `mobile-dev-inc/test-maestro-cd` action
- 支持 `maestro-cloud` 云端执行

### GitLab CI
- Docker 内运行 Maestro
- 需要挂载 Android SDK

## 依赖项

```
项目依赖:
├── maestro (CLI)
├── java (>= 11)
├── android-sdk (API 33+)
├── android-emulator (可选)
└── docker (CI)
```
