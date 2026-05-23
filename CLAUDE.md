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

---

## Maszyny

### 💻 Laptop
- **Monitory:** eDP-1 (2880x1800, wbudowany) + DP-1 (5120x1440) + HDMI-A-1 (3440x1440)
- **GPU:** (zintegrowany / dedykowany — bez specjalnych NVIDIA quirks)
- **Specyficzne:** `UserConfigs/LaptopDisplay.conf`, `UserConfigs/Laptops.conf` (touchpad, jasność)
- **`machine.conf`** (wymagany, pusty wystarczy):
  ```bash
  touch ~/.config/hypr/UserConfigs/machine.conf
  ```

### 🖥️ Stacjonarka
- **GPU:** NVIDIA GeForce RTX 4080, sterownik 595.71.05
- **DRM devices:** `card0` = ASPEED BMC (karta serwerowa, ignorować!), `card1` = RTX 4080
- **Hardware cursors:** `no_hardware_cursors = 1` (force disable dla NVIDIA) w `UserSettings.conf`
- **Wallpaper daemon:** zainstalowane `awww` (fork `swww` z identycznym API, inna nazwa binarki)
  - Wszystkie skrypty używają `awww`/`awww-daemon` zamiast `swww`/`swww-daemon`
  - Cache: `~/.cache/awww/` (nie `~/.cache/swww/`)
- **`machine.conf`** (gitignorowany, tworzony lokalnie):
  ```ini
  env = AQ_DRM_DEVICES,/dev/dri/card1
  env = LIBVA_DRIVER_NAME,nvidia
  env = __GLX_VENDOR_LIBRARY_NAME,nvidia
  env = NVD_BACKEND,direct
  env = GSK_RENDERER,ngl
  ```
  Bez tych zmiennych: wolne animacje, hyprlock nie przyjmuje klawiatury.

---

## Hyprland (wspólne)

Live config: `config/hypr/` → `~/.config/hypr` (symlink)

### Struktura config/hypr/
- `hyprland.conf` — główny, source'uje resztę
- `configs/Keybinds.conf` — keybindy (domyślne)
- `UserConfigs/` — tutaj idą wszystkie personalizacje użytkownika
  - `01-UserDefaults.conf` — `$term = ghostty`, `$files = thunar`
  - `ENVariables.conf` — zmienne środowiskowe (w tym NVIDIA)
  - `UserSettings.conf` — dwindle, master, general, input, misc, cursor
  - `WindowRules.conf` — reguły okien (opacity Emacs: `0.9 0.85`)
  - `Startup_Apps.conf` — autostart (wallpaper: `gritty.png` przez `awww`)
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
- Daemon: `awww-daemon` (na stacjonarce), `swww-daemon` (jeśli na laptopie `swww` jest zainstalowane)
  - **Uwaga:** na stacjonarce zainstalowany jest pakiet `awww`, nie `swww` — wszystkie skrypty już zaktualizowane

### hyprlock
- Config: `config/hypr/hyprlock.conf` (dla 2K), `hyprlock-1080p.conf`
- Tło: `~/.config/hypr/wallpaper_effects/.wallpaper_current`
- Uruchamiany przez `hypridle` (10 min) lub `loginctl lock-session`
- **Znany problem na NVIDIA:** jeśli nie da się wpisać hasła → sprawdź czy env NVIDIA są ustawione

---

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

---

## Zmienne środowiskowe (wymagane)

```bash
export ANTHROPIC_API_KEY="sk-ant-..."   # gptel w Doom Emacs
```

Dodać do `~/.zshrc` lub `~/.zshenv`.

---

## Rust

- Nightly: `rustc 1.90.0-nightly`
- rust-analyzer: `~/.cargo/bin/rust-analyzer`
- `~/.cargo/bin` musi być w PATH

---

## Instalacja na nowej maszynie

```bash
git clone git@github.com:piotrzarycki/dotfiles-1.git ~/projects/dotfiles-1
cd ~/projects/dotfiles-1

# symlinki (.config/doom, config/alacritty, itd.)
./install.sh link

# Hyprland — osobna funkcja z backupem istniejącego katalogu
./install.sh hypr

# Wallpaper domyślny
sudo pacman -S archlinux-wallpaper
cp /usr/share/backgrounds/archlinux/gritty.png ~/Pictures/wallpapers/

# Po instalacji: skonfiguruj monitors.conf (gitignorowany, machine-specific)
# Możesz użyć nwg-displays albo wpisać ręcznie, np.:
#   monitor=DP-1,2560x1440@144,0x0,1.0

# Doom Emacs
doom sync
```

### Stacjonarka — dodatkowe kroki po instalacji
1. Sprawdź czy `awww` jest zainstalowane: `pacman -Q awww`
   - Jeśli nie: zainstaluj z AUR (`yay -S awww`) lub podmień na `swww` i zaktualizuj skrypty
2. Sprawdź DRM devices: `ls -la /dev/dri/` — RTX 4080 powinien być `card1`
3. Stwórz `~/.config/hypr/UserConfigs/machine.conf` (plik **nie** jest w repo, ale **musi** istnieć — Hyprland 0.55 nie obsługuje optional include):
   ```ini
   env = AQ_DRM_DEVICES,/dev/dri/card1
   env = LIBVA_DRIVER_NAME,nvidia
   env = __GLX_VENDOR_LIBRARY_NAME,nvidia
   env = NVD_BACKEND,direct
   env = GSK_RENDERER,ngl
   ```
   Jeśli `card1` to nie RTX 4080, dostosuj `AQ_DRM_DEVICES`.

### Czego NIE ma w repo (machine-specific)
- `config/hypr/monitors.conf` — konfiguracja monitorów (gitignored)
- `ANTHROPIC_API_KEY` — klucz API do gptel
