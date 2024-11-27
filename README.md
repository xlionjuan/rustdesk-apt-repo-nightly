# rustdesk-apt-repo-nightly

[![Create Repo for RustDesk Nightly](https://github.com/xlionjuan/rustdesk-apt-repo-nightly/actions/workflows/nightly.yml/badge.svg)](https://github.com/xlionjuan/rustdesk-apt-repo-nightly/actions/workflows/nightly.yml)

> [!IMPORTANT]  
> This is ***unofficial*** [RustDesk](https://github.com/rustdesk/rustdesk/) apt repo, what I can say is *trust me bro*, it is your decision to trust me or not.

> [!NOTE]  
> You're viewing **Nightly** channel, [click me to check **latest** channel.](https://github.com/xlionjuan/rustdesk-apt-repo-latest)

> [!NOTE]  
> Same thing but [RPM](https://github.com/xlionjuan/rustdesk-rpm-repo) is also available.

This repo will use modified version of [morph027/apt-repo-action](https://github.com/xlionjuan/apt-repo-action) and [xlionjuan/fedora-createrepo-image](https://github.com/xlionjuan/fedora-createrepo-image) to create repo, and deploy to GitHub Pages.

The `.sh` script is written by ChatGPT, it will fetch the release data from GitHub API and use [jq](https://github.com/jqlang/jq) to parse JSON data and find the asset URL.

## Architectures

This repo privides following architectures

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
Nightly and latest are sharing same GPG key.
```
curl -fsSL https://xlionjuan.github.io/rustdesk-apt-repo-nightly/gpg.key | sudo gpg --yes --dearmor --output /usr/share/keyrings/xlion-repo.gpg
```

### Add apt source
#### For Ubuntu 24 / Debian 12 or latter (Deb822 style format)

```bash
curl -fsSl https://xlionjuan.github.io/rustdesk-apt-repo-nightly/nightly.sources | sudo tee /etc/apt/sources.list.d/xlion-rustdesk-repo.sources
```

<details>
<summary>If you wants Cloudflare...</summary>
<br>
GitHub is using Fastly CDN, which performs terrible on lots of countries, I also pushed the repo to Cloudflare R2, which has better speed.

But due to bot fight mode is enabled, some VPS providers such as AWS, Azure (GitHub Actions) will be blocked, please use GitHub Pages instead.

```bash
curl -fsSl https://xlionjuan.github.io/rustdesk-apt-repo-nightly/nightly-r2.sources | sudo tee /etc/apt/sources.list.d/xlion-rustdesk-repo.sources
```

</details>

#### For older version


```bash
curl -fsSl https://xlionjuan.github.io/rustdesk-apt-repo-nightly/nightly.list | sudo tee /etc/apt/sources.list.d/xlion-rustdesk-repo.list
```

<details>
<summary>If you wants Cloudflare...</summary>
<br>
GitHub is using Fastly CDN, which performs terrible on lots of countries, I also pushed the repo to Cloudflare R2, which has better speed.

But due to bot fight mode is enabled, some VPS providers such as AWS, Azure (GitHub Actions) will be blocked, please use GitHub Pages instead.

```bash
curl -fsSl https://xlionjuan.github.io/rustdesk-apt-repo-nightly/nightly-r2.list | sudo tee /etc/apt/sources.list.d/xlion-rustdesk-repo.list
```

> [!NOTE]  
> Deb822 style format are designed for more human readable, older style format will still supported on newer systems.

## Install/Upgrade RustDesk
```bash
sudo apt update && sudo apt install rustdesk
```

