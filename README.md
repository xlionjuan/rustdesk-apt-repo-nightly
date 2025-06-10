# rustdesk-apt-repo-nightly

[![Create Repo for RustDesk Nightly](https://github.com/xlionjuan/rustdesk-apt-repo-nightly/actions/workflows/nightly.yml/badge.svg)](https://github.com/xlionjuan/rustdesk-apt-repo-nightly/actions/workflows/nightly.yml)

> [!IMPORTANT]  
> This is ***unofficial*** [RustDesk](https://github.com/rustdesk/rustdesk/) apt repo, what I can say is *trust me bro*, it is your decision to trust me or not.

> [!NOTE]  
> You're viewing **Nightly** channel, [click me to check **latest** channel.](https://github.com/xlionjuan/rustdesk-apt-repo-latest)

> [!NOTE]  
> Same thing but [RPM](https://github.com/xlionjuan/rustdesk-rpm-repo) is also available.

> [!NOTE]  
> Cloudflare R2 source is deprecated, but it will still available for some time.

This repo will use modified version of [morph027/apt-repo-action](https://github.com/xlionjuan/apt-repo-action) and [xlionjuan/fedora-createrepo-image](https://github.com/xlionjuan/fedora-createrepo-image) to create repo, and deploy to GitHub Pages.

The `.sh` script is written by ChatGPT, it will fetch the release data from GitHub API and use [jq](https://github.com/jqlang/jq) to parse JSON data and find the asset URL.

## Architectures

This repo provides following architectures

* `amd64`  (x86_64)
* `arm64`  (aarch64)
* `armhf`  (armv7)
* `i386`   (x86_32) (Actually nothing, just prevent error if your system enabled `i386`.)

And `armhf` only has sciter verion.

## Update frequency

* Nightly: Every 3 AM UTC, because RustDesk's Nightly will build a little over 2 hours.
* latest: Every Saturday

## Add this repo
### Add GPG key

Please install [xlion-repo-archive-keyring](https://github.com/xlionjuan/xlion-repo-archive-keyring) package, you need to have `jq` and `curl` installed, this command will query GitHub API to get letest keyring package and install it. If you're mind installing by this way, please go to [its releases](https://github.com/xlionjuan/xlion-repo-archive-keyring/releases) and verify it with SHA256.

```
sudo apt-get update && sudo apt-get install -y jq curl && url=$(curl -s https://api.github.com/repos/xlionjuan/xlion-repo-archive-keyring/releases/latest | jq -r '.assets[] | select(.name | endswith(".deb")) | .browser_download_url') && tmpfile="/tmp/$(basename "$url")" && curl -L "$url" -o "$tmpfile" && sudo dpkg -i "$tmpfile"
```

### Add apt source

`.sources` format are supported on all systems.

```bash
curl -fsSl https://xlionjuan.github.io/rustdesk-apt-repo-nightly/nightly.sources | sudo tee /etc/apt/sources.list.d/xlion-rustdesk-repo.sources
```

## Install/Upgrade RustDesk

```bash
sudo apt update && sudo apt install rustdesk
```

### Versioning

I use `fpm` to modify the version with current date, so you'll never need to run `reinstall` in order to upgrade.

## License

This repository is intended for distributing software. Unless otherwise specified, all scripts and configurations are licensed under the [GNU AGPLv3](LICENSE). **THIS DOES NOT INCLUDE THE DISTRIBUTED SOFTWARE ITSELF**. For the licenses of the distributed software, please refer to the software developers' websites, Git repositories, the packages' metadata, or contact the developers directly if you have any questions.