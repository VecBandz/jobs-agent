# Claude Code on Termux (Android)

Steps to get Claude Code running on your phone via Termux. I can't install
anything on your device remotely — these are the steps to run yourself.

## 1. Install Termux

Do **not** use the Play Store version — it's outdated and unmaintained.
Install from one of these instead:

- F-Droid: https://f-droid.org/en/packages/com.termux/
- GitHub releases: https://github.com/termux/termux-app/releases

## 2. Run the install script

Open Termux and run:

```sh
curl -O https://raw.githubusercontent.com/VecBandz/jobs-agent/main/termux/install-claude-code.sh
bash install-claude-code.sh
```

(Or copy `install-claude-code.sh` from this repo onto your phone and run it
directly with `bash install-claude-code.sh`.)

The script will:

1. Update Termux's package lists.
2. Install Node.js (LTS), git, and ripgrep.
3. Grant Termux access to shared storage (`termux-setup-storage`).
4. Install the Claude Code CLI globally with `npm install -g @anthropic-ai/claude-code`.
5. Verify the `claude` command is available.

## 3. Log in and start using it

```sh
claude
```

The first run walks you through authentication (browser login or an API
key). After that, `claude` works like any other terminal AI coding
assistant — `cd` into a project directory and run `claude` there.

## Troubleshooting

- **`claude: command not found` after install** — restart Termux (kill and
  reopen the app) so your `PATH` picks up npm's global bin directory, then
  retry.
- **`npm install` fails with permission errors** — don't use `sudo`; Termux
  packages should never be installed as root. Re-run `pkg update -y` and
  try again.
- **Storage prompt didn't appear** — run `termux-setup-storage` manually
  and approve the Android permission dialog.
- **Out of disk space** — Termux and Node.js need a few hundred MB free;
  check with `df -h $HOME`.
