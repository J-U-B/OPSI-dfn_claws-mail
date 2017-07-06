.PHONY: header clean mpimsp dfn mpimsp_test dfn_test all_test all_prod all help

OPSI_BUILDER = opsi-makeproductfile

header:
	@echo "=================================================="
	@echo "             Building OPSI package(s)"
	@echo "=================================================="

mpimsp: header
	@echo "---------- building MPIMSP package -------------------------------"
	@make 	TESTING=""	\
			ORGNAME=MPIMSP \
			ORGPREFIX="" \
	build

dfn: header
	@echo "---------- building DFN package ----------------------------------"
	@make 	TESTING="" \
			ORGNAME=DFN \
			ORGPREFIX=dfn_ \
	build

mpimsp_test: header
	@echo "---------- building MPIMSP testing package -----------------------"
	@make 	TESTING="0_"	\
			ORGNAME=MPIMSP \
			ORGPREFIX="" \
	build

dfn_test: header
	@echo "---------- building DFN testing package --------------------------"
	@make 	TESTING=0_ \
			ORGNAME=DFN \
			ORGPREFIX=dfn_ \
	build

clean: header
	@echo "---------- cleaning packages, checksums and zsync ----------------"
	@rm -f *.md5 *.opsi *.zsync
	
help: header
	@echo "----- valid targets: -----"
	@echo "* mpimsp"
	@echo "* mpimsp_test"
	@echo "* dfn"
	@echo "* dfn_test"
	@echo "* all_prod"
	@echo "* all_test"

all_test:  header mpimsp_test dfn_test

all_prod : header mpimsp dfn

build:
	@rm -f OPSI/control
	@sed -e "s/{{TESTING}}/${TESTING}/" -e "s/{{ORGPREFIX}}/${ORGPREFIX}/" -e "s/{{ORGNAME}}/${ORGNAME}/"< OPSI/control.in > OPSI/control
	# @$(OPSI_BUILDER) -k -m -z
	@$(OPSI_BUILDER) -k -m


all_test:  header mpimsp_test dfn_test

all_prod : header mpimsp dfn

all : header mpimsp dfn mpimsp_test dfn_test
