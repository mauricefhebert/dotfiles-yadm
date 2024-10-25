#!/bin/bash
# dev_runner.sh
# Automate common development tasks like testing, linting, and building

case "$1" in
  test)
    echo "Running tests..."
    npm test || echo "Tests failed."
    ;;
  lint)
    echo "Running linter..."
    eslint . || echo "Linting issues found."
    ;;
  build)
    echo "Building the project..."
    npm run build || echo "Build failed."
    ;;
  all)
    echo "Running all tasks..."
    npm test && eslint . && npm run build
    ;;
  *)
    echo "Usage: $0 {test|lint|build|all}"
    ;;
esac

