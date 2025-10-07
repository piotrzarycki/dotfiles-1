;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Basic settings
(setq doom-theme 'doom-one)
(setq display-line-numbers-type t)
(setq org-directory "~/org/")

;; TypeScript configuration
(after! typescript-mode
  (setq typescript-indent-level 2))

;; LSP configuration - more conservative settings
(after! lsp-mode
  ;; Performance improvements
  (setq lsp-idle-delay 0.5)                    ; Increase from default
  (setq lsp-completion-provider :capf)
  (setq lsp-completion-enable t)
  (setq lsp-completion-show-detail t)
  (setq lsp-completion-show-kind t)
  
  ;; Disable some expensive features for better performance
  (setq lsp-enable-symbol-highlighting nil)    ; Disable symbol highlighting
  (setq lsp-ui-doc-enable nil)                 ; Disable popup documentation
  (setq lsp-ui-sideline-enable nil)            ; Disable sideline
  (setq lsp-eldoc-enable-hover nil)            ; Disable eldoc hover
  (setq lsp-signature-auto-activate nil)       ; Disable signature help
  
  ;; TypeScript specific
  (setq lsp-clients-typescript-prefer-use-project-ts-server t)
  (setq lsp-typescript-suggest-auto-imports t))

;; Company configuration - less aggressive
(after! company
  (setq company-idle-delay 0.5                 ; Increased from 0.2
        company-minimum-prefix-length 3        ; Increased from 2
        company-show-quick-access t
        company-selection-wrap-around t
        company-tooltip-align-annotations t
        company-require-match nil
        company-dabbrev-downcase nil
        company-dabbrev-ignore-case nil
        company-tooltip-limit 8                 ; Reduced from 10
        company-async-timeout 3)                ; Add timeout
  
  ;; Simpler backend configuration
  (setq company-backends
        '((company-capf company-files)          ; Group related backends
          company-keywords
          company-dabbrev-code
          company-dabbrev)))

;; Prettier configuration (manual formatting only)
(use-package! prettier
  :config
  ;; Use project-local prettier if available
  (setq prettier-pre-warm 'none)
  (setq prettier-mode-sync-config-flag t))

;; Format-all configuration (manual formatting only)
(use-package! format-all
  :config
  (setq format-all-formatters
        '(("JavaScript" prettier)
          ("TypeScript" prettier)
          ("JSON" prettier)
          ("CSS" prettier)
          ("HTML" prettier))))

;; ESLint configuration (auto-fix disabled on save)
(use-package! lsp-eslint
  :demand t
  :after lsp-mode
  :config
  ;; Configure ESLint settings
  (setq lsp-eslint-enable t)
  (setq lsp-eslint-auto-fix-on-save nil)    ; Disable auto-fix on save
  (setq lsp-eslint-run "onType")            ; Show errors as you type
  (setq lsp-eslint-package-manager "npm")   ; Use npm as package manager
  
  ;; Enable ESLint for these file extensions
  (setq lsp-eslint-validate '("javascript" "typescript" "javascriptreact" "typescriptreact")))

;; Flycheck ESLint integration
(after! flycheck
  ;; Use ESLint for JavaScript/TypeScript
  (setq-hook! 'typescript-mode-hook flycheck-checker 'javascript-eslint)
  (setq-hook! 'js2-mode-hook flycheck-checker 'javascript-eslint)
  (setq-hook! 'rjsx-mode-hook flycheck-checker 'javascript-eslint)
  
  ;; Reduce flycheck frequency to improve performance
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  
  ;; Use project-local ESLint if available
  (setq flycheck-javascript-eslint-executable nil))

;; Tree-sitter configuration - choose ONE approach
;; Option 1: Use built-in tree-sitter (recommended for newer Emacs)
(when (and (fboundp 'treesit-available-p) (treesit-available-p))
  (setq treesit-language-source-alist
        '((typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
          (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")))
  
  ;; Auto-install grammars if needed
  (dolist (lang '(typescript tsx))
    (unless (treesit-language-available-p lang)
      (treesit-install-language-grammar lang)))
      
  (add-to-list 'major-mode-remap-alist '(typescript-mode . typescript-ts-mode)))

;; LSP performance optimizations
(after! lsp-mode
  ;; Increase GC threshold during LSP operations
  (defun my/lsp-mode-setup-performance ()
    (setq-local gc-cons-threshold (* 100 1024 1024))  ; 100mb
    (setq-local read-process-output-max (* 1024 1024)) ; 1mb
    (setq-local company-idle-delay 0.8))               ; Even more conservative in LSP buffers
  
  (add-hook 'lsp-mode-hook #'my/lsp-mode-setup-performance))

;; Disable lsp-ui completely to reduce overhead
(after! lsp-ui
  (setq lsp-ui-doc-enable nil)
  (setq lsp-ui-sideline-enable nil)
  (setq lsp-ui-peek-enable nil))

;; Key bindings for formatting and linting
(map! :after lsp-mode
      :map lsp-mode-map
      "C-c h" #'lsp-describe-thing-at-point
      "C-c d" #'lsp-ui-doc-toggle)

;; Additional keybindings for Prettier and ESLint
(map! :leader
      (:prefix ("c" . "code")
       "f" #'format-all-buffer           ; Format current buffer
       "F" #'format-all-region)          ; Format region
      
      ;; Use a different prefix for linting to avoid conflicts
      (:prefix ("e" . "errors")
       "l" #'flycheck-list-errors        ; List all errors
       "n" #'flycheck-next-error         ; Next error
       "p" #'flycheck-previous-error     ; Previous error
       "f" #'lsp-eslint-fix-all          ; Fix all ESLint errors
       "r" #'flycheck-buffer))           ; Run linter

;; Jest configuration
(after! jest-test-mode
  ;; Custom Jest runner functions
  (defun my/jest-run-current-file ()
    "Run Jest on current file."
    (interactive)
    (if (buffer-file-name)
        (let ((file-name (buffer-file-name)))
          (jest-test-run file-name))
      (message "Buffer has no associated file")))

  (defun my/jest-debug ()
    "Run Jest in debug mode."
    (interactive)
    (let ((jest-test-options '("--inspect-brk" "--runInBand")))
      (call-interactively #'jest-test-run-at-point)))

  (defun my/jest-coverage ()
    "Run Jest with coverage."
    (interactive)
    (let ((jest-test-options '("--coverage")))
      (call-interactively #'jest-test-run))))

;; Enable jest-test-mode for JavaScript/TypeScript files
(add-hook 'js-mode-hook #'jest-test-mode)
(add-hook 'typescript-mode-hook #'jest-test-mode)
(add-hook 'js2-mode-hook #'jest-test-mode)
(add-hook 'rjsx-mode-hook #'jest-test-mode)

;; Jest keybindings - use only verified functions
(map! :leader
      (:prefix ("t" . "test")
       "t" #'my/jest-run-current-file     ; Run current file (custom)
       "f" #'jest-test-run-at-point       ; Run test at point
       "a" #'jest-test-run                ; Run all tests
       "r" #'jest-test-rerun-test         ; Rerun last test
       "d" #'my/jest-debug                ; Debug mode
       "c" #'my/jest-coverage))           ; With coverage

;; Wayland clipboard integration
(when (and (getenv "WAYLAND_DISPLAY") (executable-find "wl-copy"))
  (setq interprogram-cut-function
        (lambda (text &optional push)
          (with-temp-buffer
            (insert text)
            (call-process-region (point-min) (point-max) "wl-copy" nil nil nil)))
        interprogram-paste-function
        (lambda ()
          (with-temp-buffer
            (when (zerop (call-process "wl-paste" nil t nil))
              (buffer-string)))))
  
  ;; Enable clipboard integration
  (setq select-enable-clipboard t
        select-enable-primary t))

;; Define keybindings for clipboard operations
(map! :leader
      :desc "Copy to clipboard" "y" #'kill-ring-save
      :desc "Paste from clipboard" "p" #'yank)

;; Make visual selection copy to clipboard
(map! :v "y" (lambda () (interactive) 
               (kill-ring-save (region-beginning) (region-end))
               (message "Copied to clipboard!")))
