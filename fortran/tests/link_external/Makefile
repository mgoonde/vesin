F90 := gfortran
MPIF90 := mpif90
FC_MODINC := -I
FC_MODOUT := -J

SRC := .
OBJ := Obj

## name of output library
LIBNAME := libvv.so

VESIN_PATH    := $(abspath ../../../)
VESIN_BUILD   := $(VESIN_PATH)/build
VESIN_LIBPATH := $(VESIN_PATH)/lib
VESIN_INCLUDE := $(VESIN_BUILD)/fortran/include


FLAGS := -O0 -cpp -ldl -fPIC -ffree-line-length-none
MOD := $(FC_MODOUT)$(OBJ) $(FC_MODINC)$(OBJ)

# "external" libs and modules
EXT_LIB := -L$(VESIN_LIBPATH) -lvesin -lstdc++
EXT_MOD := $(FC_MODINC)$(VESIN_INCLUDE)

mod_f := $(SRC)/m_neighbour.f90
mod_o := $(mod_f:$(SRC)/%.f90=$(OBJ)/%.o)

base_f := $(SRC)/base.f90
base_o := $(base_f:$(SRC)/%.f90=$(OBJ)/%.o)


default: all
all: vesin $(OBJ) lib

## Obj dir
$(OBJ):
	@if [ ! -d $(OBJ) ]; then mkdir $(OBJ) ; fi


# vesin_submod:
# 	@if test ! -d $(VESIN_PATH)/vesin; then \
# 	git submodule update --init --recursive; fi


## compile vesin
vesin: #vesin_submod
	@cd ${VESIN_PATH} && cmake -B ${VESIN_BUILD} -DVESIN_FORTRAN=ON -DCMAKE_INSTALL_PREFIX=./
	@cd ${VESIN_PATH} && cmake --build ${VESIN_BUILD}
	@cd ${VESIN_PATH} && cmake --install ${VESIN_BUILD}


lib: $(mod_o) $(base_o)
	$(MPIF90) $(MOD) $(EXT_MOD) -fPIC -shared -o $(LIBNAME) $^ $(EXT_LIB)

clean:
	rm -rf $(OBJ)
	rm -rf $(VESIN_BUILD) ${VESIN_LIBPATH} ${VESIN_INCLUDE}


# .f90 files
$(OBJ)/%.o: $(SRC)/%.f90
	$(MPIF90) $(MOD) $(EXT_MOD) $(FLAGS) -c  $^ -o $@
