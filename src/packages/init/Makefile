# Makefile for Application Program

#INIT_BOOTCHART = true

CROSS_COMPILE = /opt/toolchains/arm-eabi-4.2.1/bin/arm-eabi-
LDPATH = /opt/toolchains/arm-eabi-4.2.1/lib

CC	:= $(CROSS_COMPILE)gcc
CPP	:= $(CROSS_COMPILE)g++

UC_MACH_TYPE = INSTINCTQ

$(info $(UC_MACH_TYPE))

CFLAGS	:= -Wall \
		-I/opt/toolchains/arm-eabi-4.2.1/libc/include \
		-I/opt/toolchains/arm-eabi-4.2.1/libc/arch-arm/include \
		-I/opt/toolchains/arm-eabi-4.2.1/libc/kernel/common \
		-I/opt/toolchains/arm-eabi-4.2.1/libc/kernel/arch-arm \
		-I/opt/toolchains/arm-eabi-4.2.1/core/include \
		-DCONFIG_MACH_${UC_MACH_TYPE} \

LDFLAGS	:= -L$(LDPATH)

SRCS	:= builtins.c \
		init.c \
		devices.c \
		property_service.c \
		util.c \
		parser.c \
		logo.c

ifeq ($(strip $(INIT_BOOTCHART)),true)
SRCS   += bootchart.c
CFLAGS += -DBOOTCHART=1
endif
CFLAGS += -DWIFI_ADDR

TARGETS	:= $(SRCS:.c=)
OBJS	:= $(SRCS:.c=.o)
PROG	:= init
LIB		:= $(LDPATH)/liblog.a \
		$(LDPATH)/libcutils.a \
		$(LDPATH)/libc.a \
		$(LDPATH)/gcc/arm-eabi/4.2.1/interwork/libgcc.a

all	: depend $(OBJS) $(PROG)

%.o	: %.c
	$(CC) $(CFLAGS) -c $<

$(PROG): $(OBJS)
	$(CPP) -nostdlib -Bstatic -Wl,-T,armelf.x \
	-Wl,--gc-sections \
	-o $@ \
	$(LDPATH)/crtbegin_static.o \
	-Wl,--no-undefined \
	$(OBJS) \
	$(LIB) \
	$(LDPATH)/crtend_android.o

clean : 
	rm -f $(PROG) $(TARGETS) .depend $(OBJS) $(SOBJS) *~

depend : Makefile $(SRCS)
	$(CC) -M $(CFLAGS) $(SRCS) > .$@

install:
	cp -dpf $(PROG) $(ROOT)/$(PROG)
	/usr/local/arm/4.3.1-eabi-armv6/usr/bin/arm-linux-strip --strip-unneeded $(ROOT)/$(PROG)

-include .depend
