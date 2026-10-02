LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),M5A)

# Symlinks that exist on the stock vendor/odm images (PRODUCT_COPY_FILES cannot create them).
# /vendor/lib/modules -> /vendor_dlkm/lib/modules is required: init.insmod.sh and
# init.insmod.cfg load every vendor module through that path.
M5A_VENDOR_SYMLINKS := \
    $(TARGET_OUT_VENDOR)/lib/modules:/vendor_dlkm/lib/modules \
    $(TARGET_OUT_VENDOR)/odm:/odm \
    $(TARGET_OUT_VENDOR)/firmware/tsx_data:/mnt/vendor/productinfo/wcn/tsx_bt_data.txt \
    $(TARGET_OUT_VENDOR)/lib/npidevice/libsensornpi.so:/vendor/lib/libsensornpi.so \
    $(TARGET_OUT_VENDOR)/lib/npidevice/libnpi_rtc.so:/vendor/lib/libnpi_rtc.so \
    $(TARGET_OUT_ODM)/lib/npidevice/libcamcalitest.so:/odm/lib/libcamcalitest.so

M5A_SYMLINK_TARGETS := $(foreach s,$(M5A_VENDOR_SYMLINKS),$(firstword $(subst :, ,$(s))))

$(M5A_SYMLINK_TARGETS): M5A_LINKS := $(M5A_VENDOR_SYMLINKS)
$(M5A_SYMLINK_TARGETS):
	@echo "M5A symlink: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf $(patsubst $@:%,%,$(filter $@:%,$(M5A_LINKS))) $@

ALL_DEFAULT_INSTALLED_MODULES += $(M5A_SYMLINK_TARGETS)

endif
