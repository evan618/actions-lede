#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default static IP
sed -i 's/192.168.1.1/192.168.99.1/g' package/base-files/files/bin/config_generate

# Modify default hostname
sed -i 's/OpenWrt/GWRT/g' package/base-files/files/bin/config_generate

# 适配 32M FLASH 支持
#sed -i 's/<0xa0000 0xf60000>/<0xa0000 0x1fb0000>/g' target/linux/ramips/dts/mt7621_phicomm_k2p.dts

# 适配 32M images镜像
#sed -i 's/15744k/32448k/g' target/linux/ramips/image/mt7621.mk
# 添加 banner
cat files/banner > package/base-files/files/etc/banner
# 增加构建时间

sed -i '/DISTRIB_REVISION/d' package/lean/default-settings/files/zzz-default-settings
sed -i '/exit 0/i sed -i '\''/DISTRIB_REVISION/d'\'' /etc/openwrt_release' package/lean/default-settings/files/zzz-default-settings
sed -i '/exit 0/i echo "DISTRIB_REVISION='\''$(date +%Y-%m-%d-%H:%M) GWRT @ R23.7.7'\''" >> /etc/openwrt_release' package/lean/default-settings/files/zzz-default-settings

sed -i '/DISTRIB_DESCRIPTION/d' package/lean/default-settings/files/zzz-default-settings
sed -i '/exit 0/i sed -i '\''/DISTRIB_DESCRIPTION/d'\'' /etc/openwrt_release' package/lean/default-settings/files/zzz-default-settings
sed -i '/exit 0/i echo "DISTRIB_DESCRIPTION='\''GWRT '\''" >> /etc/openwrt_release' package/lean/default-settings/files/zzz-default-settings
