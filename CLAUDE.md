# Dotfiles — kontekst dla Claude

## Właściciel
Piotr Zarycki (`piotrzarycki`) — developer, używa Arch Linux + Hyprland na desktopie i laptopie.

## Struktura repo

```
dotfiles-1/
├── .config/
│   ├── doom/          # Doom Emacs config (zlinkowane do ~/.config/doom)
│   ├── nvim/          # Neovim config
│   ├── alacritty/     # Terminal
│   └── kitty/         # Terminal (główny na Hyprland)
├── Arch-Hyprland/     # Symlink -> /projects/Arch-Hyprland (Hyprland dots)
├── zsh/               # Zsh config
└── install.sh         # Instalator (linkuje pliki .symlink)
```

## Środowisko

- **OS:** Arch Linux
- **WM:** Hyprland (Wayland)
- **Shell:** Zsh
- **Terminal:** Kitty
- **Editor:** Doom Emacs + Neovim
- **Monitor:** DP-1 (2560x1440)

## Doom Emacs

Konfiguracja w `.config/doom/`. Aktywne moduły:
- LSP (`lsp +peek`) — główny backend dla wszystkich języków
- `(rust +lsp)` — Rust przez rustic + rust-analyzer (`~/.cargo/bin/rust-analyzer`)
- `(typescript +lsp +tree-sitter +jest)` — TS/JS z ESLint, Prettier, Jest
- `(javascript +lsp +tree-sitter +jest)`
- `corfu +orderless` — completion
- `vertico` — minibuffer
- `magit` — git
- `vterm` — terminal w Emacsie

### Ważne ustawienia
- `lsp-rust-analyzer-cargo-watch-command "clippy"` — clippy zamiast check
- `rustic-format-on-save t` — rustfmt przy zapisie
- gptel (Claude) — klucz przez `ANTHROPIC_API_KEY` env var (nie hardkodować!)
- Wayland clipboard przez `wl-copy`/`wl-paste`

## Hyprland (Arch-Hyprland)

Osobne repo: `github.com/piotrzarycki/Hyprland-Dots` (fork JaKooLit).

### Ważne zmiany po migracji
- **swww → awww** — wszystkie skrypty używają `awww`/`awww-daemon`, NIE `swww`
- `awww` cache jest w `~/.cache/awww/<wersja>/` (podkatalog z numerem wersji)
- `awww query` zwraca format `: DP-1: ...` (nie `Monitor DP-1:`)
- Wallpaper domyślny: `~/Pictures/wallpapers/Northern Lights3.png`

### Skróty klawiaturowe (wallpaper)
- `Super+W` — wybór wallpapera (rofi)
- `Super+Shift+W` — efekty wallpapera
- `Ctrl+Alt+W` — losowy wallpaper

## Zmienne środowiskowe (wymagane)

```bash
export ANTHROPIC_API_KEY="sk-ant-..."   # gptel w Doom Emacs
```

Dodać do `~/.zshrc` lub `~/.zshenv`.

## Rust

- Nightly: `rustc 1.90.0-nightly`
- rust-analyzer: `~/.cargo/bin/rust-analyzer`
- `~/.cargo/bin` musi być w PATH

## Instalacja na nowej maszynie

```bash
git clone git@github.com:piotrzarycki/dotfiles-1.git ~/dotfiles-1
cd ~/dotfiles-1 && ./install.sh

# Hyprland dots
git clone git@github.com:piotrzarycki/Hyprland-Dots.git
cd Hyprland-Dots && ./copy.sh

# Doom Emacs
doom sync
```
