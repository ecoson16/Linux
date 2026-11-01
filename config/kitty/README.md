## Scroll behavior
Kitty normally follows new output while you're at the bottom, and stops following when you scroll up to inspect history. `Ctrl+Shift+Home` jumps to the top of scrollback; `Ctrl+Shift+End` returns to the bottom. `Ctrl+Shift+Up/Down` scrolls one line. New output from a running command is not supposed to force you back down if you've manually scrolled up.
The shell prompt appears after Fastfetch on startup, so the visible output is naturally near the top of the screen. Kitty has no general setting to pin every new session's scroll position to the top while also leaving the interactive prompt ready below it.

## Cut shortcut
Terminal output is not an editable document, so there is no true cut operation for output text. Select text and use `Ctrl+Shift+C` to copy it. Kitty's default `Ctrl+Shift+X` is used to jump to the next shell prompt, so it is intentionally preserved. `Ctrl+X` is left alone so it continues to work normally in your shell/editor.

## Font
This uses `Maple Mono NF CN`. If unavailable, run `kitty +list-fonts | grep -i maple` and set `font_family` to the exact installed family name.
