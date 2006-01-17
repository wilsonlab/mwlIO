
clean: 
	rm -rf build \
	rm -f *.rpm


BUILD_DIR = build
RPM_NAME = mwlIO

build:
	mkdir -p $(BUILD_DIR)/$(RPM_NAME)
	cp -r -f doc $(BUILD_DIR)/$(RPM_NAME)
	cp -r -f private $(BUILD_DIR)/$(RPM_NAME)
	cp -r -f @header $(BUILD_DIR)/$(RPM_NAME)
	cp -r -f @subheader $(BUILD_DIR)/$(RPM_NAME)
	cp -r -f @mwl* $(BUILD_DIR)/$(RPM_NAME)
	cp -r -f src $(BUILD_DIR)/$(RPM_NAME)
	cp -r -f include $(BUILD_DIR)/$(RPM_NAME)
	cp -r -f *.m *.spec *.xml Makefile $(BUILD_DIR)/$(RPM_NAME)

mex: build
	cd $(BUILD_DIR)/$(RPM_NAME) ; \
	matlabR14 -nojvm -nosplash -nodisplay -r "makesources,quit"



# you will want to add 'export RPMBASE=~/rpm' or somesuch to your .bashrc file
MWLARCH=i386

#mwl-wilson-software
RPM_VER=$(shell sed -e '/^Version: */!d; s///;q' $(RPM_NAME).spec)
RPM_REL=$(shell sed -e '/^Release: */!d; s///;q' $(RPM_NAME).spec)

rpm: mex
	cd $(BUILD_DIR) ; \
        tar czvf $(RPM_NAME).tar.gz $(RPM_NAME) ; \
        mv -f $(RPM_NAME).tar.gz $(RPMBASE)/SOURCES/
	rpmbuild -bb $(RPM_NAME).spec
	cp $(RPMBASE)/RPMS/$(MWLARCH)/$(RPM_NAME)-$(RPM_VER)-$(RPM_REL).$(MWLARCH).rpm . 
