# THE FOLLOWING VARIABLES CAN BE MODIFIED TO YOUR NEEDS
#
# name of build directory
BUILD_DIR = build
# yes/no build mex files
BUILDMEX = no
# yes/no build documentation (requires fkHelp toolbox)
BUILDDOC = yes
# command line options for matlab
MATLABOPTIONS = -nosplash -nodesktop
# matlab binary
MATLABBIN = matlabR14
# documentation path
DOCPATH = html


# DO NOT CHANGE THE FOLLOWING VARIABLES
#
# toolbox name
RPM_NAME=$(shell sed -e '/^Name: */!d; s///;q' *.spec)
# toolbox version, release number and release date
RPM_VER=$(shell sed -e '/^Version: */!d; s///;q' $(RPM_NAME).spec)
RPM_REL=$(shell sed -e '/^Release: */!d; s///;q' $(RPM_NAME).spec)
RELDATE=$(shell date +%d-%b-%Y)
# computer architecture (for creating rpm)
MWLARCH=$(shell sed -e '/^BuildArch: */!d; s///;q' $(RPM_NAME).spec)
# matlab command (leave empty)
MATLABCOMMAND = 
BUILDDOCCMD = 
BUILDMEXCMD = 

# construct matlab command
ifeq ($(BUILDDOC),yes)
BUILDDOCCMD = generate_help('.','$(RPM_NAME)'),quit
endif

ifeq ($(BUILDMEX),yes)
BUILDMEXCMD = makesources,
endif

MATLABCOMMAND = p=pwd;cd('~');startup;cd(p);$(BUILDMEXCMD)$(BUILDDOCCMD)

PKGNAME = $(RPM_NAME)-$(RPM_VER)-$(RPM_REL).$(MWLARCH)

clean: 
	rm -rf build \
	rm -f *.tar.gz \
	rm -f *.rpm

# if you have other file types / directories that need to be included,
# add lines below to copy these to the build directory
build:
	mkdir -p $(BUILD_DIR)/$(RPM_NAME)
	cp -r -f $(DOCPATH) $(BUILD_DIR)/$(RPM_NAME)
	cp -r -f private $(BUILD_DIR)/$(RPM_NAME)
	cp -r -f @header $(BUILD_DIR)/$(RPM_NAME)
	cp -r -f @subheader $(BUILD_DIR)/$(RPM_NAME)
	cp -r -f @mwl* $(BUILD_DIR)/$(RPM_NAME)
	cp -r -f src $(BUILD_DIR)/$(RPM_NAME)
	cp -r -f include $(BUILD_DIR)/$(RPM_NAME)
	cp -r -f *.m *.spec Makefile $(BUILD_DIR)/$(RPM_NAME)
	cd $(BUILD_DIR)/$(RPM_NAME) ; \
	sed -i -e "s/VERSIONNUMBER/$(RPM_VER).$(RPM_REL)/g" Contents.m ; \
	sed -i -e "s/RELEASEDATE/$(RELDATE)/g" Contents.m ; \


# build sources and documentation
mex: build
	cd $(BUILD_DIR)/$(RPM_NAME) ; \
	sed -i -e "/Program version/s/'local'/'$(RPM_VER)-$(RPM_REL)'/g" \@mwlfilebase/closeHeader.m ; \
	if test -n "$(MATLABCOMMAND)"; then $(MATLABBIN) $(MATLABOPTIONS) -r "$(MATLABCOMMAND)"; fi ;\
	if test "$(BUILDDOC)" = "yes"; then sed -i -e "s/VERSIONNUMBER/$(RPM_VER)-$(RPM_REL)/g" $(DOCPATH)/$(RPM_NAME)_product_page.html ; fi ;\
	if test "$(BUILDDOC)" = "yes"; then sed -i -e "s/RELEASEDATE/$(RELDATE)/g" $(DOCPATH)/$(RPM_NAME)_product_page.html ; fi

# create tarball
tar: mex
	cd $(BUILD_DIR) ; \
	tar czvf $(PKGNAME).tar.gz $(RPM_NAME) ; \
	mv -f $(PKGNAME).tar.gz ..

# create zip
zip: mex
	cd $(BUILD_DIR) ; \
	zip -r $(PKGNAME) $(RPM_NAME) ; \
	mv -f $(PKGNAME).zip ..

# create rpm
# you will want to add 'export RPMBASE=~/rpm' or somesuch to your .bashrc file
rpm: tar
	cp -f $(PKGNAME).tar.gz $(RPMBASE)/SOURCES/ ;\
	rpmbuild -bb $(RPM_NAME).spec ;\
	cp $(RPMBASE)/RPMS/$(MWLARCH)/$(PKGNAME).rpm . 