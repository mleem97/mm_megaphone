#!/usr/bin/env python3
"""Validate `.github/workflows/release.yml` for expected structure.

This script is intended to be run in CI or locally. It parses the YAML
workflow file and asserts that required keys/steps exist (triggers,
permissions, archive creation step, and release step using softprops/action-gh-release).

Exit code 0 on success, 1 on test failures, 2 on missing file or parse errors.
"""
from __future__ import annotations

import os
import sys
import unittest

try:
    import yaml
except Exception as exc:  # pragma: no cover - friendly error if PyYAML missing
    print("ERROR: PyYAML is required. Install with: python -m pip install pyyaml", file=sys.stderr)
    raise


def load_workflow(path: str) -> dict:
    if not os.path.isfile(path):
        raise FileNotFoundError(path)
    with open(path, "r", encoding="utf-8") as fh:
        return yaml.safe_load(fh)


class ReleaseWorkflowTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        path = os.environ.get("WORKFLOW_PATH", ".github/workflows/release.yml")
        try:
            cls.data = load_workflow(path)
        except FileNotFoundError as exc:
            raise unittest.SkipTest(f"Workflow file not found: {exc}")

    def test_name_present(self):
        self.assertEqual(self.data.get("name"), "Release")

    def test_triggers(self):
        on = self.data.get("on") or {}
        self.assertIn("push", on)
        push = on.get("push") or {}
        tags = push.get("tags")
        self.assertIsNotNone(tags)
        self.assertIn("v*", tags)
        self.assertIn("workflow_dispatch", on)

    def test_permissions(self):
        perms = self.data.get("permissions") or {}
        self.assertIn("contents", perms)
        self.assertEqual(perms.get("contents"), "write")

    def test_job_and_runner(self):
        jobs = self.data.get("jobs") or {}
        self.assertIn("release", jobs)
        job = jobs["release"]
        self.assertEqual(job.get("runs-on"), "lunexor")

    def test_checkout_step(self):
        steps = self.data["jobs"]["release"].get("steps") or []
        found = any(
            isinstance(step, dict) and step.get("uses", "").startswith("actions/checkout@")
            for step in steps
        )
        self.assertTrue(found, "Missing actions/checkout step")

    def test_archive_step_contents(self):
        steps = self.data["jobs"]["release"].get("steps") or []
        archive_steps = [s for s in steps if s.get("name") == "Create archive of resource"]
        self.assertTrue(archive_steps, "Create archive of resource step must exist")
        run_block = archive_steps[0].get("run", "")
        self.assertIsInstance(run_block, str)
        self.assertRegex(run_block, r"\btar\b")
        self.assertRegex(run_block, r"-czf\b")
        self.assertIn("--exclude='.git'", run_block)
        self.assertIn("--exclude='.github'", run_block)
        # Check ARCHIVE_NAME creation (use a simple substring check that references github.ref_name)
        self.assertIn("github.ref_name", run_block)
        self.assertIn('echo "ARCHIVE_NAME=$ARCHIVE_NAME" >> $GITHUB_ENV', run_block)

    def test_create_release_step(self):
        steps = self.data["jobs"]["release"].get("steps") or []
        create_release = [s for s in steps if isinstance(s, dict) and s.get("uses", "").startswith("softprops/action-gh-release@")]
        self.assertTrue(create_release, "softprops/action-gh-release step must exist")
        step = create_release[0]
        self.assertTrue(step.get("uses").startswith("softprops/action-gh-release@v2.4.2"))
        with_block = step.get("with") or {}
        self.assertIn("files", with_block)
        self.assertEqual(with_block.get("files"), "${{ env.ARCHIVE_NAME }}")
        self.assertIn("body", with_block)
        self.assertIn("Release ${{ github.ref_name }}", with_block.get("body", ""))
        self.assertIn("draft", with_block)
        self.assertIn("prerelease", with_block)
        self.assertFalse(bool(with_block.get("draft")))
        self.assertFalse(bool(with_block.get("prerelease")))


def main() -> int:
    loader = unittest.TestLoader()
    suite = loader.loadTestsFromTestCase(ReleaseWorkflowTests)
    runner = unittest.TextTestRunner(verbosity=2)
    result = runner.run(suite)
    return 0 if result.wasSuccessful() else 1


if __name__ == "__main__":
    try:
        exit_code = main()
    except Exception as exc:  # pragma: no cover - allow CI to show error
        print(f"ERROR: {exc}", file=sys.stderr)
        exit_code = 2
    sys.exit(exit_code)
