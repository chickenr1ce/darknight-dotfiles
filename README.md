# dotfiles

Managed with [chezmoi](https://www.chezmoi.io). The source of truth is this
directory, a normal git checkout, so it can be opened as a project in T3 Code
or any editor.

## Layout

File names encode the target path in `$HOME`:

| Source name | Becomes |
| --- | --- |
| `dot_config/fish/config.fish` | `~/.config/fish/config.fish` |
| `dot_gitconfig` | `~/.gitconfig` |
| `executable_dot_local/bin/foo` | `~/.local/bin/foo`, mode 755 |
| `private_dot_config/foo` | `~/.config/foo`, mode 600 |
| `dot_config/foo.conf.tmpl` | `~/.config/foo.conf`, rendered as a template |

`chezmoi cd` drops you into this directory. `chezmoi managed` lists every
target path. `chezmoi source-path ~/.config/fish/config.fish` shows where a
live file lives in here.

## Daily use

```fish
chezmoi add ~/.config/fish/config.fish   # track a file or directory
chezmoi edit ~/.config/fish/config.fish  # edit the source copy
chezmoi diff                             # what apply would change
chezmoi apply                            # write source to $HOME
chezmoi cd                               # shell in the source, git works normally
```

Editing the live file in `$HOME` and then running `chezmoi add` also works.
That is how this repo was seeded.

## New machine

```fish
git clone git@github.com:chickenr1ce/darknight-dotfiles.git ~/dotfiles
mkdir -p ~/.config/chezmoi
printf 'sourceDir = "~/dotfiles"\n' > ~/.config/chezmoi/chezmoi.toml
chezmoi diff    # review before touching anything
chezmoi apply
```

The config file has to exist first because it is what points chezmoi at
`~/dotfiles` instead of its default `~/.local/share/chezmoi`.

## Per-host differences

Templates get `.chezmoi.hostname`, `.chezmoi.os`, `.chezmoi.arch` and any
`data` block from `~/.config/chezmoi/chezmoi.toml` without extra setup:

```
{{ if eq .chezmoi.hostname "omarchy" }}
set -gx HSA_OVERRIDE_GFX_VERSION 12.0.1
{{ end }}
```

Rename a file to `*.tmpl` with `chezmoi chattr +template`, then edit it.

## Deliberately not tracked

- `~/.config/fish/fish_variables`: fish rewrites it, and it holds absolute
  paths and plugin state. Reproduce it with `fisher install` on a new machine.
- `~/.config/rofi/{applets,launchers,powermenu,images}`: vendored rofi theme.
  Only `config.rasi` and `colors/` are ours.
- `~/.config/opencode/node_modules` and `~/.config/opencode/service.json`:
  installed packages and a local auth token.
- `~/.config/quickshell`: has its own repository.
- `~/.local/bin` binaries. Only the hand-written scripts are tracked.
- `~/.config/micro/syntax` and `~/.config/yazi/flavors`: vendored.
- `~/.dotfiles`: the old bare repo, kept as a backup. Delete it once this
  setup has proven itself.
