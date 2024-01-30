#!/bin/bash

# Выполнение команды poetry update
poetry update

# Выполнение команды pre-commit install
pre-commit install

HOOKS_DIR=".git/hooks"
PRE_COMMIT_HOOK="$HOOKS_DIR/pre-commit"
SCRIPT_PATH="../prepare-commit-msg" # Укажите путь к вашему скрипту

function configure_pre_commit_hook() {
  # Проверяем наличие директории .git/hooks
  if [ ! -d "$HOOKS_DIR" ]; then
    echo "Directory $HOOKS_DIR not found. Are you inside a Git repository?"
    exit 1
  fi

  # Проверяем существование файла pre-commit
  if [ ! -f "$PRE_COMMIT_HOOK" ]; then
    # Создаем новый pre-commit хук
    echo "#!/bin/bash" > "$PRE_COMMIT_HOOK"
    echo "" >> "$PRE_COMMIT_HOOK"
    echo "# Automatically added by script" >> "$PRE_COMMIT_HOOK"
    echo "$SCRIPT_PATH \"\$1\"" >> "$PRE_COMMIT_HOOK"
    chmod +x "$PRE_COMMIT_HOOK"
    echo "pre-commit hook created and configured."
  else
    # Проверяем, есть ли уже вызов скрипта в pre-commit хуке
    if grep -q "$SCRIPT_PATH" "$PRE_COMMIT_HOOK"; then
      echo "Script already configured in pre-commit hook."
    else
      # Добавляем вызов скрипта в конец pre-commit хука
      echo "" >> "$PRE_COMMIT_HOOK"
      echo "# Automatically added by script" >> "$PRE_COMMIT_HOOK"
      echo "$SCRIPT_PATH \"\$1\"" >> "$PRE_COMMIT_HOOK"
      echo "Script added to pre-commit hook."
    fi
  fi
}

# Вызов функции для настройки pre-commit хука
configure_pre_commit_hook

echo "Done."
