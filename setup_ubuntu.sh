#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
SDK_REPO_DIR=${PXREA_SDK_REPO_DIR:-"$ROOT_DIR/../XRoboToolkit-PC-Service"}
PYTHON_BIN=${PYTHON_BIN:-python}

if [[ ! -d "$SDK_REPO_DIR/.git" ]]; then
    echo "Cloning XRoboToolkit-PC-Service into $SDK_REPO_DIR"
    git clone --branch main --single-branch https://github.com/XR-Robotics/XRoboToolkit-PC-Service.git "$SDK_REPO_DIR"
fi

echo "Building PXREARobotSDK from $SDK_REPO_DIR"
bash "$SDK_REPO_DIR/RoboticsService/PXREARobotSDK/build.sh"

echo "Installing xrobotoolkit_sdk with $PYTHON_BIN"
if "$PYTHON_BIN" -m pip --version >/dev/null 2>&1; then
    "$PYTHON_BIN" -m pip install --force-reinstall "$ROOT_DIR"
elif command -v uv >/dev/null 2>&1; then
    uv pip install --python "$PYTHON_BIN" --force-reinstall "$ROOT_DIR"
else
    echo "Neither '$PYTHON_BIN -m pip' nor 'uv pip' is available."
    exit 1
fi
