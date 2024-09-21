# rustdesk-apt-repo-nightly

> [!NOTE]  
> You're viewing **Nightly** channel, [click me to check **latest** channel.](https://github.com/xlionjuan/rustdesk-apt-repo-latest)


> [!IMPORTANT]  
> This is ***unofficial*** [RustDesk](https://github.com/rustdesk/rustdesk/) apt repo, what I can say is *trust me bro*, it is your decision to trust me or not.

This repo will use [morph027/apt-repo-action](https://github.com/morph027/apt-repo-action) to create repo, and deploy to GitHub Pages.

The `.sh` script is writed by ChatGPT, it will fetch the release data from GitHub API and use [jq](https://github.com/jqlang/jq) to parse JSON data and find the asset URL.

## Architectures

This repo privides following architectures

* `amd64`  (x86_64)
* `arm64`  (aarch64)
* `armhf`  (armv7)

And `armhf` only has sciter verion.

## Update frequency

* Nightly: Every 3 AM UTC, because RustDesk's Nightly will run a little over 2 hours.
* latest: Every Saturday

## Add this repo
### Add GPG key
Nightly and latest are sharing same GPG key.
```
curl -fsSL https://raw.githubusercontent.com/xlionjuan/rustdesk-apt-repo-nightly/refs/heads/main/pubkey.gpg | sudo gpg --yes --dearmor --output /usr/share/keyrings/xlion-repo.gpg
```

### Add apt source
#### For Ubuntu 24 / Debian 12 or latter (Deb822 style format)

```bash
sudo tee /etc/apt/sources.list.d/xlion-rustdesk-repo.sources << EOF
# Change "nightly" to "latest" if you want to switch channel
Types: deb
URIs: https://xlionjuan.github.io/rustdesk-apt-repo-nightly
Suites: main
Components: main
Signed-By: /usr/share/keyrings/xlion-repo.gpg
EOF
```

#### For older version

```bash
sudo tee /etc/apt/sources.list.d/xlion-rustdesk-repo.list << EOF
# Change "nightly" to "latest" if you want to switch channel
deb [signed-by=/usr/share/keyrings/xlion-repo.gpg] https://xlionjuan.github.io/rustdesk-apt-repo-nightly main main
EOF
```

> [!NOTE]  
> Deb822 style format are designed for more human readable, older style format will still supported on newer systems.

## Update to same version number of nightly

Because RustDesk didn't change its version number or add special identify when releasing nightly, so you could run
```bash
sudo apt reinstall rustdesk
```
to upgrade manually, still better than download manually.

> [!CAUTION]
> Don't asking me to doing this.