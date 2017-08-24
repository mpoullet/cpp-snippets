# https://stackoverflow.com/a/16346321
create_bin_dir := $(shell mkdir -p ./bin)

BINDIR := ./bin

CPPFLAGS := -I ./
CXXFLAGS := -std=c++14 -Wall -Wextra -Werror -pedantic
LDFLAGS := -lpthread

targets :=\
	multithreading01\
	min_element01\
	raii01\
	type_traits\
	reading_from_files

define make-target
$(1): $(1).o
	@echo "LD $(1)"
	$(CXX) -o $(BINDIR)/$(1) $(1).o $(LDFLAGS)
all:: $(1)
endef

$(foreach element,$(targets),$(eval $(call make-target,$(element))))

clean:
	rm -rf *.o $(BINDIR)/*

.PHONY: all clean

%.o: %.cpp
	@echo "CXX $<"
	$(CXX) -c -o $@ $< $(CPPFLAGS) $(CXXFLAGS)

# http://make.mad-scientist.net/managing-recipe-echoing/
$(V).SILENT:
