# Copyright (C) 2010 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


# This file is the device-specific product definition file for
# odroidx2. It lists all the overlays, files, modules and properties
# that are specific to this hardware: i.e. those are device-specific
# drivers, configuration files, settings, etc...

# These is the hardware-specific overlay, which points to the location
# of hardware-specific resource overrides, typically the frameworks and
# application settings that are stored in resourced.

LOCAL_PATH := device/hardkernel/odroidx2
KERNEL_DIR ?= ../kernel

include $(LOCAL_PATH)/BoardConfig.mk

include device/rockchip/common/phone/rk30_phone.mk
# Get the long list of APNs
PRODUCT_COPY_FILES += device/rockchip/common/phone/etc/apns-full-conf.xml:system/etc/apns-conf.xml
PRODUCT_COPY_FILES += device/rockchip/common/phone/etc/spn-conf.xml:system/etc/spn-conf.xml

DEVICE_PACKAGE_OVERLAYS := $(LOCAL_PATH)/overlay

ifeq ($(BOARD_USES_HGL),true)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/conf/egl.cfg:system/lib/egl/egl.cfg \
    hardware/samsung_slsi/exynos4/lib/mali_ump/libEGL_mali.so:system/lib/egl/libEGL_mali.so \
    hardware/samsung_slsi/exynos4/lib/mali_ump/libGLESv1_CM_mali.so:system/lib/egl/libGLESv1_CM_mali.so \
    hardware/samsung_slsi/exynos4/lib/mali_ump/libGLESv2_mali.so:system/lib/egl/libGLESv2_mali.so \
    hardware/samsung_slsi/exynos4/lib/mali_ump/libMali.so:system/lib/libMali.so \
    hardware/samsung_slsi/exynos4/lib/mali_ump/libMali.so:obj/lib/libMali.so \
    hardware/samsung_slsi/exynos4/lib/mali_ump/libUMP.so:system/lib/libUMP.so \
    hardware/samsung_slsi/exynos4/lib/mali_ump/libUMP.so:obj/lib/libUMP.so \
    hardware/samsung_slsi/exynos4/lib/mali_ump/libion.so:system/lib/libion.so \
    hardware/samsung_slsi/exynos4/lib/mali_ump/libion.so:obj/lib/libion.so
endif

# Init files
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/conf/init.odroidx2.rc:root/init.odroidx2.rc \
    $(LOCAL_PATH)/conf/init.odroidx2.usb.rc:root/init.odroidx2.usb.rc \
    $(LOCAL_PATH)/conf/fstab.odroidx2:root/fstab.odroidx2 \
    $(LOCAL_PATH)/conf/fstab.odroidx2.sdboot:root/fstab.odroidx2.sdboot

# For V4L2
ifeq ($(BOARD_USE_V4L2), true)
ifeq ($(BOARD_USE_V4L2_ION), true)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/conf/ueventd.odroidx2.v4l2ion.rc:root/ueventd.odroidx2.rc
else
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/conf/ueventd.odroidx2.v4l2.rc:root/ueventd.odroidx2.rc
endif
else
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/conf/ueventd.odroidx2.rc:root/ueventd.odroidx2.rc
endif

# Filesystem management tools
PRODUCT_PACKAGES += \
    make_ext4fs \
    setup_fs

#3G Modem
PRODUCT_PACKAGES += \
    rild

# audio
PRODUCT_PACKAGES += \
    audio_policy.$(TARGET_PRODUCT) \
    audio.primary.$(TARGET_PRODUCT) \
    audio.a2dp.default \
    libaudioutils \
    audio.r_submix.default

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio_policy.conf:/system/etc/audio_policy.conf

# ALP Audio
ifeq ($(BOARD_USE_ALP_AUDIO),true)
PRODUCT_PACKAGES += \
    libOMX.SEC.MP3.Decoder
endif

# Camera
PRODUCT_PACKAGES += \
    camera.$(TARGET_PRODUCT)

# gralloc add by bbk for user mode
PRODUCT_PACKAGES += \
    gralloc.$(TARGET_PRODUCT)

# gps
PRODUCT_PACKAGES += \
    gps.$(TARGET_PRODUCT)

# Custom Update packages
PRODUCT_PACKAGES += \
    OdroidUpdater \
    Utility

PRODUCT_PACKAGES += \
    Superuser \
    su

# Libs
PRODUCT_PACKAGES += \
    libstagefrighthw \
    com.android.future.usb.accessory

# Misc other modules
PRODUCT_PACKAGES += \
    lights.$(TARGET_PRODUCT) \
    hwcomposer.exynos4

# OpenMAX IL configuration files
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/media_profiles.xml:system/etc/media_profiles.xml

# OpenMAX IL modules
PRODUCT_PACKAGES += \
    libSEC_OMX_Core \
    libSEC_OMX_Resourcemanager \
    libOMX.SEC.AVC.Decoder \
    libOMX.SEC.M4V.Decoder \
    libOMX.SEC.M4V.Encoder \
    libOMX.SEC.AVC.Encoder

# hwconvertor modules
PRODUCT_PACKAGES += \
    libhwconverter \
    libswconverter \
    libswscaler

# MFC firmware
PRODUCT_COPY_FILES += \
    hardware/samsung_slsi/exynos4/firmware/mfc_fw.bin:system/vendor/firmware/mfc_fw.bin

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.audio.low_latency.xml:system/etc/permissions/android.hardware.audio.low_latency.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    packages/wallpapers/LivePicker/android.software.live_wallpaper.xml:system/etc/permissions/android.software.live_wallpaper.xml

# The OpenGL ES API level that is natively supported by this device.
# This is a 16.16 fixed point number
PRODUCT_PROPERTY_OVERRIDES := \
    ro.opengles.version=131072

PRODUCT_PROPERTY_OVERRIDES += \
    debug.hwui.render_dirty_regions=false

# Set default USB interface
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.usb.config=mass_storage \
    ro.kernel.android.checkjni=0

# Device uses high-density artwork where available
PRODUCT_AAPT_CONFIG := normal hdpi xhdpi xxhdpi
PRODUCT_AAPT_PREF_CONFIG := xhdpi xxhdpi

PRODUCT_CHARACTERISTICS := tablet

# call dalvik heap config
$(call inherit-product-if-exists, frameworks/native/build/phone-xxhdpi-2048-dalvik-heap.mk)

# call hwui memory config
$(call inherit-product-if-exists, frameworks/native/build/phone-xxhdpi-2048-hwui-memory.mk)

PRODUCT_TAGS += dalvik.gc.type-precise

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml

PRODUCT_PROPERTY_OVERRIDES += \
    ro.sf.lcd_density=160

PRODUCT_PACKAGES += \
    sqlite3 \
    stagefright

# we have enough storage space to hold precise GC data
PRODUCT_TAGS += dalvik.gc.type-precise

# hwconvertor modules
PRODUCT_PACKAGES += \
    libhwconverter

#codec.bin for audio analog parameters ---Add by CYIT
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/conf/codec.bin:system/etc/audio/codec.bin

#media codec file
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/media_codecs.xml:system/etc/media_codecs.xml

PRODUCT_PROPERTY_OVERRIDES += \
    wifi.interface=wlan0 \
    wifi.supplicant_scan_interval=15

# Prebuilt kl keymaps
PRODUCT_COPY_FILES += \
    device/hardkernel/proprietary/bin/odroid-ts.idc:system/usr/idc/odroidx-ts.idc \
    device/hardkernel/proprietary/bin/odroid-ts.kl:system/usr/keylayout/odroidx-ts.kl \
    device/hardkernel/proprietary/bin/odroid-ts.kcm:system/usr/keylayout/odroidx-ts.kcm \
    device/hardkernel/proprietary/bin/odroid-keypad.kl:system/usr/keylayout/odroid-keypad.kl \
    device/hardkernel/proprietary/bin/odroid-keypad.kcm:system/usr/keychars/odroid-keypad.kcm

# for USB HID MULTITOUCH
PRODUCT_COPY_FILES += \
    device/hardkernel/proprietary/bin/Vendor_03fc_Product_05d8.idc:system/usr/idc/Vendor_03fc_Product_05d8.idc \
    device/hardkernel/proprietary/bin/Vendor_1870_Product_0119.idc:system/usr/idc/Vendor_1870_Product_0119.idc \
    device/hardkernel/proprietary/bin/Vendor_1870_Product_0100.idc:system/usr/idc/Vendor_1870_Product_0100.idc \
    device/hardkernel/proprietary/bin/Vendor_2808_Product_81c9.idc:system/usr/idc/Vendor_2808_Product_81c9.idc

# XBox 360 Controller kl keymaps
    PRODUCT_COPY_FILES += \
    device/hardkernel/proprietary/bin/Vendor_045e_Product_0291.kl:system/usr/keylayout/Vendor_045e_Product_0291.kl \
    device/hardkernel/proprietary/bin/Vendor_045e_Product_0719.kl:system/usr/keylayout/Vendor_045e_Product_0719.kl \
    device/hardkernel/proprietary/bin/Vendor_045e_Product_0719.kcm:system/usr/keychars/Vendor_045e_Product_0719.kcm

PRODUCT_PACKAGES += \
    libwapi

PRODUCT_COPY_FILES += \
    device/hardkernel/proprietary/apk/Ultra_Explorer.apk:system/app/Ultra_Explorer.apk \
    device/hardkernel/proprietary/apk/jackpal.androidterm.apk:system/app/jackpal.androidterm.apk \
    device/hardkernel/proprietary/lib/libjackpal-androidterm4.so:system/lib/libjackpal-androidterm4.so

PRODUCT_COPY_FILES += \
    device/hardkernel/proprietary/apk/DicePlayer.apk:system/app/DicePlayer.apk \
    device/hardkernel/proprietary/lib/libSoundTouch.so:system/lib/libSoundTouch.so \
    device/hardkernel/proprietary/lib/libdice_kk.so:system/lib/libdice_kk.so \
    device/hardkernel/proprietary/lib/libdice_loadlibrary.so:system/lib/libdice_loadlibrary.so \
    device/hardkernel/proprietary/lib/libdice_software.so:system/lib/libdice_software.so \
    device/hardkernel/proprietary/lib/libdice_software_kk.so:system/lib/libdice_software_kk.so \
    device/hardkernel/proprietary/lib/libffmpeg_dice.so:system/lib/libffmpeg_dice.so \
    device/hardkernel/proprietary/lib/libsonic.so:system/lib/libsonic.so

# init.d support
PRODUCT_COPY_FILES += \
    device/hardkernel/proprietary/bin/sysinit:system/bin/sysinit

# ups2.sh
PRODUCT_COPY_FILES += \
    device/hardkernel/odroidu/ups2.sh:system/bin/ups2.sh

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rt5370sta.cal:system/etc/firmware/rt5370sta.cal \
    $(LOCAL_PATH)/rt2870.bin:system/etc/firmware/rt2870.bin \
    $(LOCAL_PATH)/wifi_id_list.txt:system/etc/wifi_id_list.txt
