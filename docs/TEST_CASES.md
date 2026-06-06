# TEST_CASES.md — TestMate 测试案例

## T-2026-00206: Maestro 核心部署 + Android 模拟器 E2E 验证

### AC-1: Maestro CLI 本地安装 + 版本验证

| Case-ID | 描述 | 执行命令 | 预期结果 |
|---------|------|----------|----------|
| TC-001 | Maestro CLI 安装验证 | `maestro --version` | 输出版本号，exit 0 |
| TC-002 | Maestro 安装脚本执行 | `./scripts/install-maestro.sh` | 脚本成功完成，exit 0 |

### AC-5: YAML 测试流编写 + Android 模拟器运行

| Case-ID | 描述 | 执行命令 | 预期结果 |
|---------|------|----------|----------|
| TC-003 | 示例 YAML 测试流语法验证 | `maestro validate flows/sample-flow.yaml` | YAML 语法正确 |
| TC-004 | 部署验证脚本执行 | `./scripts/verify-deployment.sh` | 所有检查项通过 |
| TC-005 | Maestro CLI 可用性检查 | `cd /mnt/d/openworkspace/jinggo-company/company-repos/project-testmate && maestro --version && echo "Maestro CLI OK"` | 输出版本号 + "Maestro CLI OK" |

### AC-7: 行业模板库开发 + CI/CD 集成

| Case-ID | 描述 | 执行命令 | 预期结果 |
|---------|------|----------|----------|
| TC-006 | 电商模板完整性检查 | `ls templates/ecommerce/` | 包含 login-flow.yaml, checkout-flow.yaml, search-flow.yaml |
| TC-007 | 社交模板完整性检查 | `ls templates/social/` | 包含 register-flow.yaml, post-flow.yaml, interact-flow.yaml |
| TC-008 | 金融模板完整性检查 | `ls templates/finance/` | 包含 login-flow.yaml, transfer-flow.yaml, statement-flow.yaml |
| TC-009 | GitHub Actions 配置验证 | `cat ci/github-actions.yml` | 包含 maestro 测试步骤 |
| TC-010 | GitLab CI 配置验证 | `cat ci/gitlab-ci.yml` | 包含 maestro 测试步骤 |
