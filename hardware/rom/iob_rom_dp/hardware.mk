ifneq ($(ASIC),1)
ifneq (iob_rom_dp,$(filter $S, $(MODULES)))

# Add to modules list
MODULES+=iob_rom_dp

# Paths
DPROM_DIR=$(MEM_ROM_DIR)/iob_rom_dp

# Sources
VSRC+=$(DPROM_DIR)/iob_rom_dp.v

endif
endif