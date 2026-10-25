# Linux Dotfiles

My personal Linux setup for Arch Linux and CachyOS, featuring a blue-and-black Hyprland configuration, Noctalia desktop shell, Fastfetch customization, Thunar settings, and a collection of custom cursor themes.

## What's Included

### Configuration

- `config/hypr/` – Hyprland Lua configuration and Hyprlock settings
- `config/noctalia/` – Noctalia user configuration, saved GUI settings, and a full configuration snapshot
- `config/fastfetch/` – Fastfetch system information layout and colors
- `config/Thunar/` – Thunar keyboard shortcuts and custom actions

### Cursor Themes

The `cursors/` directory contains 16 cursor themes:

Black Cat, Blade, Boothill, Chisa, Hakurei Reimu, Hiro, Hornet Hollow Knight, Hoshimi Miyabi, Kitasan, Kurumi Tokisaki, Mint Fantome, Mr. C.B., Saber Alter, Sparkle, Specter the Unchained Black, and Yuurei Angel.

## 1. Requirements

This setup is primarily intended for Arch Linux and CachyOS.

Install the main system packages:

```bash
sudo pacman -S hyprland hyprlock git \
    xfce4-terminal thunar networkmanager \
    network-manager-applet fastfetch qt6ct \
    hyprpolkitagent
```

Install [Noctalia](https://docs.noctalia.dev/) using its official instructions.

Some applications used by my keybindings are installed separately:

- **Google Chrome** – launched using `google-chrome-stable`
- **Prism Launcher** – launched through Flatpak
- **Noctalia** – desktop shell, launcher, and screenshot tools

Install the applications you use, or change their commands in `config/hypr/hyprland.lua` to match your system.

**Note:** This configuration uses Hyprland's Lua configuration format. Make sure your installed Hyprland version supports it.

## 2. Clone the Repository

```bash
git clone https://github.com/ecoson16/Linux.git ~/Linux
cd ~/Linux
```

## 3. Restore Hyprland and Hyprlock

Back up your existing Hyprland configuration before restoring mine:

```bash
[ -d ~/.config/hypr ] && \
    cp -a ~/.config/hypr \
    ~/.config/hypr.backup-$(date +%Y%m%d-%H%M%S)

mkdir -p ~/.config/hypr
cp -a ~/Linux/config/hypr/. ~/.config/hypr/
```

Review `~/.config/hypr/hyprland.lua` before restarting your session.

The configuration includes:

- Blue and black window styling
- Window animations, gaps, borders, and blur
- Keyboard shortcuts and window management
- Noctalia and NetworkManager applet autostart
- Hyprlock configuration
- Sparkle cursor theme selection

Some settings are hardware-specific, including the touchpad and mouse device names. Update those sections if your devices differ.

The Hyprlock configuration uses this wallpaper path:

```text
~/Pictures/wallpaper.jpg
```

Place your wallpaper there or edit `~/.config/hypr/hyprlock.conf` to use another image.

Reload the configuration after making changes:

```bash
hyprctl reload
```

## 4. Restore Noctalia

For Noctalia v5+, the active user configuration belongs in `~/.config/noctalia/`, while GUI-managed settings are stored in `~/.local/state/noctalia/settings.toml`.

Back up existing files first, then restore the repository's configuration:

```bash
mkdir -p ~/.config/noctalia ~/.local/state/noctalia

[ -f ~/.config/noctalia/config.toml ] && \
    cp -a ~/.config/noctalia/config.toml \
    ~/.config/noctalia/config.toml.backup

[ -f ~/.local/state/noctalia/settings.toml ] && \
    cp -a ~/.local/state/noctalia/settings.toml \
    ~/.local/state/noctalia/settings.toml.backup

cp ~/Linux/config/noctalia/noctalia-config.toml \
    ~/.config/noctalia/config.toml

cp ~/Linux/config/noctalia/settings.toml \
    ~/.local/state/noctalia/settings.toml
```

The `noctalia-full-config.toml` file is a full snapshot for reference. **Do not copy it into the active configuration directory** as an additional configuration file.

Some settings may reference my wallpaper, display, screenshot folders, or installed plugins. Adjust these to match your system.

Validate the configuration:

```bash
noctalia config validate
```

Official documentation: https://docs.noctalia.dev/

## 5. Install a Cursor Theme

Choose a theme from the `cursors/` directory. For example, to install Sparkle:

```bash
mkdir -p ~/.local/share/icons
cp -a ~/Linux/cursors/Sparkle ~/.local/share/icons/
```

You can replace `Sparkle` with any of the other theme directory names.

To use the theme in Hyprland, check the cursor-related settings in `~/.config/hypr/hyprland.lua`. For example:

```lua
hl.env("HYPRCURSOR_THEME", "Sparkle")
hl.env("XCURSOR_THEME", "Sparkle")
hl.env("HYPRCURSOR_SIZE", "32")
hl.env("XCURSOR_SIZE", "32")
```

After logging in, apply the cursor theme:

```bash
hyprctl setcursor Sparkle 32
```

Change the theme name and size to your preference. Some applications may require a restart or a new login session to pick up cursor changes.

## 6. Restore Fastfetch

Back up your existing Fastfetch configuration if you have one, then copy mine:

```bash
[ -d ~/.config/fastfetch ] && \
    cp -a ~/.config/fastfetch \
    ~/.config/fastfetch.backup-$(date +%Y%m%d-%H%M%S)

mkdir -p ~/.config/fastfetch
cp -a ~/Linux/config/fastfetch/. ~/.config/fastfetch/
```

Run Fastfetch to check the result:

```bash
fastfetch
```

## 7. Restore Thunar Settings

Restore the included Thunar configuration files:

```bash
[ -d ~/.config/Thunar ] && \
    cp -a ~/.config/Thunar \
    ~/.config/Thunar.backup-$(date +%Y%m%d-%H%M%S)

mkdir -p ~/.config/Thunar
cp -a ~/Linux/config/Thunar/. ~/.config/Thunar/
```

These files include keyboard shortcut settings and custom actions. Restart Thunar if the changes do not appear immediately.

## Notes

- These are personal dotfiles, not a universal plug-and-play configuration.
- Back up your existing files before replacing them.
- Check application commands, hardware-specific device names, wallpaper paths, and display settings before using the configuration.
- Install any required applications and Noctalia plugins separately.
- Pixie SDDM is an optional external theme and is not included in this repository: https://github.com/xCaptaiN09/pixie-sddm
- Review configuration snapshots before publishing. Never commit passwords, API tokens, private keys, or other secrets.

## Links

- **Repository:** https://github.com/ecoson16/Linux
- **Hyprland:** https://wiki.hypr.land/
- **Noctalia:** https://docs.noctalia.dev/
- **Pixie SDDM:** https://github.com/xCaptaiN09/pixie-sddm
