#!/bin/bash
#========================================================================================================================
# https://github.com/ophub/amlogic-s9xxx-openwrt
# Description: Automatically Build OpenWrt
# Function: Diy script (Before Update feeds, Modify the default IP, hostname, theme, add/remove software packages, etc.)
# Source code repository: https://github.com/coolsnowwolf/lede / Branch: master
#========================================================================================================================

# Add a feed source
# sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package' feeds.conf.default

# other
# rm -rf package/lean/{samba4,luci-app-samba4,luci-app-ttyd}

echo 'src-git kenzo https://github.com/kenzok8/openwrt-packages' >> feeds.conf.default
echo 'src-git small https://github.com/kenzok8/small' >> feeds.conf.default

# 更新并安装 feeds
./scripts/feeds update -a
./scripts/feeds install -a

# 单独安装 PassWall (确保其被拉取)
./scripts/feeds install luci-app-passwall
# 强制删除 6.18 内核下会引发报错的 shortcut-fe 补丁
rm -f target/linux/generic/hack-6.18/953-net-patch-linux-kernel-to-support-shortcut-fe.patch
rm -f target/linux/generic/hack-6.18/613-netfilter_optional_tcp_window_check.patch
