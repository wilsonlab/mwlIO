
clean: 
	rm -rf build \
	rm -f *.tar.gz \
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


# you will want to add 'export RPMBASE=~/rpm' or somesuch to your .bashrc file
MWLARCH=i386

#mwl-wilson-software
RPM_VER=$(shell sed -e '/^Version: */!d; s///;q' $(RPM_NAME).spec)
RPM_REL=$(shell sed -e '/^Release: */!d; s///;q' $(RPM_NAME).spec)


mex: build
	cd $(BUILD_DIR)/$(RPM_NAME) ; \
	sed -i -e "/Program version/s/''/'$(RPM_VER)-$(RPM_REL)'/g" \@mwlfilebase/closeHeader.m ; \
	matlabR14 -nosplash -nodisplay -r "makesources,generate_toolbox_help('.','$(RPM_NAME)'),quit" ; \
	sed -i -e "s/VERSIONNUMBER/$(RPM_VER)-$(RPM_REL)/g" doc/$(RPM_NAME)_product_page.html

tar: mex
	cd $(BUILD_DIR) ; \
	tar czvf $(RPM_NAME).tar.gz $(RPM_NAME) ; \
	mv -f $(RPM_NAME).tar.gz ..

rpm: tar
	cp -f $(RPM_NAME).tar.gz $(RPMBASE)/SOURCES/ ;\
	rpmbuild -bb $(RPM_NAME).spec ;\
	cp $(RPMBASE)/RPMS/$(MWLARCH)/$(RPM_NAME)-$(RPM_VER)-$(RPM_REL).$(MWLARCH).rpm . 
