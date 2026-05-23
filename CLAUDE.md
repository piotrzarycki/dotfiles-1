# Dotfiles — kontekst dla Claude

## Właściciel
Piotr Zarycki (`piotrzarycki`) — developer, Arch Linux + Hyprland na laptopie i desktopie.

## Struktura repo

```
dotfiles-1/
├── .config/
│   ├── doom/              # Doom Emacs config → ~/.config/doom
│   ├── nvim/              # Neovim config
│   └── kitty/             # Kitty (zapasowy terminal)
├── config/
│   ├── alacritty/         # → ~/.config/alacritty
│   ├── hypr/              # Hyprland config → ~/.config/hypr  ← główny
│   └── ...                # inne: install.sh linkuje config/* do ~/.config/*
├── Hyprland-Dots/         # submodule: github.com/piotrzarycki/Hyprland-Dots (fork JaKooLit)
│                          # używany jako referencja/template, NIE jako live config
├── zsh/                   # Zsh config
└── install.sh             # Instalator (symlinki .symlink + config/*)
```

### Jak działa install.sh
- Pliki `*.symlink` → linkowane do `~/.<nazwa>`
- Katalogi w `config/` → linkowane do `~/.config/<nazwa>`
- Osobna funkcja `setup_hypr` obsługuje `~/.config/hypr` z backupem

## Środowisko

- **OS:** Arch Linux (laptop + desktop)
- **WM:** Hyprland 0.55+ (Wayland)
- **Shell:** Zsh
- **Terminal:** Ghostty (główny), Kitty (zapasowy)
- **Editor:** Doom Emacs + Neovim
- **Monitory (laptop):** eDP-1 (2880x1800) + DP-1 (5120x1440) + HDMI-A-1 (3440x1440)

## Hyprland

Live config: `config/hypr/` → `~/.config/hypr` (symlink)

### Struktura config/hypr/
- `hyprland.conf` — główny, source'uje resztę
- `configs/Keybinds.conf` — keybindy (domyślne)
- `UserConfigs/` — tutaj idą wszystkie personalizacje użytkownika
  - `01-UserDefaults.conf` — `$term = ghostty`, `$files = ...`
  - `UserSettings.conf` — dwindle, master, general, input, misc
  - `WindowRules.conf` — reguły okien (opacity Emacs: `0.9 0.85`)
  - `Startup_Apps.conf` — autostart (wallpaper: `gritty.png`)
- `scripts/` — skrypty pomocnicze (wallpaper, layout, volume, itd.)
- `UserScripts/` — skrypty użytkownika
- `monitors.conf` — **gitignorowany**, machine-specific (nwg-displays)
- `workspaces.conf` — reguły workspace'ów

### Ważne keybindy (wallpaper)
- `Super+W` — wybór wallpapera (rofi)
- `Super+Shift+W` — efekty wallpapera
- `Ctrl+Alt+W` — losowy wallpaper

### Hyprland 0.55 — usunięte/zmienione opcje
Po upgrade (2026-05-21) naprawione deprecacje:
- `togglesplit` → `layoutmsg, togglesplit` (`configs/Keybinds.conf` + `scripts/ChangeLayout.sh`)
- `dwindle { pseudotile = true }` — usunąć (działa tylko przez dispatcher `Super+P`)
- `misc { vfr = true }` — usunąć (VFR zawsze włączone)

### Wallpaper
- Domyślny: `gritty.png` z pakietu `archlinux-wallpaper`
- Ścieżka: `~/Pictures/wallpapers/gritty.png` (skopiowany z `/usr/share/backgrounds/archlinux/`)

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
- Motyw: doom-tokyo-night, ligatures, rainbow-delimiters, transparent background
- Opacity window rule w Hyprlandzie: `opacity 0.9 0.85`

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
git clone git@github.com:piotrzarycki/dotfiles-1.git ~/projects/dotfiles-1
cd ~/projects/dotfiles-1

# symlinki (.config/doom, config/alacritty, itd.)
./install.sh link

# Hyprland — osobna funkcja z backupem istniejącego katalogu
./install.sh hypr

# Po instalacji: skonfiguruj monitors.conf (gitignorowany, machine-specific)
# Możesz użyć nwg-displays albo wpisać ręcznie, np.:
#   monitor=DP-1,2560x1440@144,0x0,1.0

# Doom Emacs
doom sync
```

### Czego NIE ma w repo (machine-specific)
- `config/hypr/monitors.conf` — konfiguracja monitorów (gitignored)
- `ANTHROPIC_API_KEY` — klucz API do gptel
