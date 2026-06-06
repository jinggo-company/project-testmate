"""
TestMate unit tests — wrapper for shell-based verification.
"""
import subprocess
import os
import unittest

PROJ_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))


def run_script(name):
    """Run a shell script and return the result."""
    result = subprocess.run(
        ["bash", os.path.join(PROJ_ROOT, "tests/unit", name)],
        capture_output=True, text=True, cwd=PROJ_ROOT
    )
    return result


class TestMaestroScripts(unittest.TestCase):
    """Test that all Maestro scripts exist and are well-formed."""

    def test_install_maestro_exists(self):
        self.assertTrue(os.path.exists(os.path.join(PROJ_ROOT, "scripts/install-maestro.sh")))

    def test_setup_emulator_exists(self):
        self.assertTrue(os.path.exists(os.path.join(PROJ_ROOT, "scripts/setup-emulator.sh")))

    def test_verify_deployment_exists(self):
        self.assertTrue(os.path.exists(os.path.join(PROJ_ROOT, "scripts/verify-deployment.sh")))

    def test_run_tests_exists(self):
        self.assertTrue(os.path.exists(os.path.join(PROJ_ROOT, "scripts/run-tests.sh")))

    def test_install_maestro_has_shebang(self):
        with open(os.path.join(PROJ_ROOT, "scripts/install-maestro.sh")) as f:
            self.assertTrue(f.readline().startswith("#!/bin/bash"))

    def test_install_maestro_has_set_flags(self):
        with open(os.path.join(PROJ_ROOT, "scripts/install-maestro.sh")) as f:
            content = f.read()
            self.assertIn("set -euo pipefail", content)

    def test_setup_emulator_has_shebang(self):
        with open(os.path.join(PROJ_ROOT, "scripts/setup-emulator.sh")) as f:
            self.assertTrue(f.readline().startswith("#!/bin/bash"))

    def test_verify_deployment_checks_maestro(self):
        with open(os.path.join(PROJ_ROOT, "scripts/verify-deployment.sh")) as f:
            content = f.read()
            self.assertIn("command -v maestro", content)


class TestYAMLTemplates(unittest.TestCase):
    """Test that all Maestro YAML templates are valid."""

    def _import_yaml(self):
        try:
            import yaml
            return yaml
        except ImportError:
            self.skipTest("PyYAML not installed")

    def test_sample_flow_valid_yaml(self):
        yaml = self._import_yaml()
        path = os.path.join(PROJ_ROOT, "flows/sample-flow.yaml")
        self.assertTrue(os.path.exists(path))
        with open(path) as f:
            docs = list(yaml.safe_load_all(f))
        self.assertGreater(len(docs), 0)

    def test_ecommerce_templates(self):
        yaml = self._import_yaml()
        for name in ["login-flow.yaml", "checkout-flow.yaml", "search-flow.yaml"]:
            path = os.path.join(PROJ_ROOT, "templates/ecommerce", name)
            self.assertTrue(os.path.exists(path), f"Missing: {path}")
            with open(path) as f:
                list(yaml.safe_load_all(f))

    def test_social_templates(self):
        yaml = self._import_yaml()
        for name in ["register-flow.yaml", "post-flow.yaml", "interact-flow.yaml"]:
            path = os.path.join(PROJ_ROOT, "templates/social", name)
            self.assertTrue(os.path.exists(path), f"Missing: {path}")
            with open(path) as f:
                list(yaml.safe_load_all(f))

    def test_finance_templates(self):
        yaml = self._import_yaml()
        for name in ["login-flow.yaml", "transfer-flow.yaml", "statement-flow.yaml"]:
            path = os.path.join(PROJ_ROOT, "templates/finance", name)
            self.assertTrue(os.path.exists(path), f"Missing: {path}")
            with open(path) as f:
                list(yaml.safe_load_all(f))


class TestCIConfig(unittest.TestCase):
    """Test that CI configs are valid."""

    def _import_yaml(self):
        try:
            import yaml
            return yaml
        except ImportError:
            self.skipTest("PyYAML not installed")

    def test_github_actions_valid(self):
        yaml = self._import_yaml()
        path = os.path.join(PROJ_ROOT, "ci/github-actions.yml")
        self.assertTrue(os.path.exists(path))
        with open(path) as f:
            data = yaml.safe_load(f)
        self.assertIsNotNone(data)

    def test_gitlab_ci_valid(self):
        yaml = self._import_yaml()
        path = os.path.join(PROJ_ROOT, "ci/gitlab-ci.yml")
        self.assertTrue(os.path.exists(path))
        with open(path) as f:
            data = yaml.safe_load(f)
        self.assertIsNotNone(data)


if __name__ == "__main__":
    unittest.main()
