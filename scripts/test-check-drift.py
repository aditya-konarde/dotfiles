#!/usr/bin/env python3
"""Exercise the drift checker and installer against isolated target homes."""

from pathlib import Path
import subprocess
import tempfile
import unittest


REPO = Path(__file__).resolve().parent.parent
CHECK = REPO / "scripts/check-drift.py"
INSTALL = REPO / "scripts/install-files.py"


class DriftCheckTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(dir=REPO)
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.manifest = self.root / "manifest"
        self.manifest.write_text("README.md -> nested/copy\n")
        self.target = self.root / "home"

    def check(self):
        return subprocess.run(
            ["python3", str(CHECK), "--manifest", str(self.manifest), "--target", str(self.target)],
            text=True, capture_output=True, check=False,
        )

    def test_missing_matching_drift_and_symlink(self):
        self.assertIn("Missing: nested/copy", self.check().stdout)
        subprocess.run(
            ["python3", str(INSTALL), "--manifest", str(self.manifest),
             "--target", str(self.target), "--apply"], check=True, capture_output=True,
        )
        self.assertEqual(self.check().returncode, 0)
        dest = self.target / "nested/copy"
        dest.write_text("changed")
        self.assertIn("Drift: nested/copy", self.check().stdout)
        dest.unlink()
        dest.symlink_to(REPO / "README.md")
        result = self.check()
        self.assertEqual(result.returncode, 1)
        self.assertIn("Symlink: nested/copy", result.stdout)
        dest.unlink()
        dest.symlink_to(self.root / "missing")
        self.assertIn("Symlink: nested/copy", self.check().stdout)

    def test_invalid_manifest(self):
        self.manifest.write_text("../escape\n")
        self.assertEqual(self.check().returncode, 2)

    def test_destination_parent_symlink_escape(self):
        self.target.mkdir()
        (self.target / "nested").symlink_to(self.root, target_is_directory=True)
        self.assertEqual(self.check().returncode, 2)


if __name__ == "__main__":
    unittest.main()
