# Makefile for borgmatic-binary
# -----------------------------

# Version and architecture

VERSION := 1.2.6
ARCH    := $(shell ./config.guess)
PYMAJOR := $(shell python -c "import sys;t='{v[0]}'.format(v=list(sys.version_info[:1]));sys.stdout.write(t)")

# Targets -

all: check-pyversion
	pip install pyinstaller
	pip install borgmatic==${VERSION}
	pip download --no-deps --no-binary :all: borgmatic==${VERSION}
	tar -xf borgmatic-${VERSION}.tar.gz
	cp specs/*.spec borgmatic-${VERSION}
	( cd borgmatic-${VERSION} ; pyinstaller borgmatic.spec )
	( cd borgmatic-${VERSION} ; pyinstaller generate-borgmatic-config.spec )
	( cd borgmatic-${VERSION} ; pyinstaller upgrade-borgmatic-config.spec )
	cp README.md borgmatic-${VERSION}/dist
	tar -C borgmatic-${VERSION}/dist -czf borgmatic-${VERSION}-${ARCH}.tar.gz README.md borgmatic generate-borgmatic-config upgrade-borgmatic-config

clean:
	rm -fr borgmatic-${VERSION}
	rm -f borgmatic-${VERSION}.tar.gz

realclean: clean
	rm -f borgmatic-${VERSION}-${ARCH}.tar.gz

check-pyversion:
ifneq ($(PYMAJOR), 3)
  $(error Python 3 is required.)
endif
