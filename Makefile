# Makefile for borgmatic-binary
# -----------------------------

# Version and architecture

VERSION := 1.5.0
ARCH    := $(shell ./config.guess)
PYMAJOR := $(shell python -c "import sys;t='{v[0]}'.format(v=list(sys.version_info[:1]));sys.stdout.write(t)")

# Check Python version_info

ifneq ($(PYMAJOR), 3)
  $(error Python 3 is required.)
endif

# Main target

all: borgmatic-${VERSION}/dist/borgmatic \
		 borgmatic-${VERSION}/dist/generate-borgmatic-config \
		 borgmatic-${VERSION}/dist/upgrade-borgmatic-config \
		 borgmatic-${VERSION}/dist/validate-borgmatic-config

# Targets - individual binaries

borgmatic-${VERSION}/dist/borgmatic: specs/borgmatic.spec borgmatic-${VERSION}
	cp specs/borgmatic.spec borgmatic-${VERSION}
	( cd borgmatic-${VERSION} ; pyinstaller borgmatic.spec )

borgmatic-${VERSION}/dist/generate-borgmatic-config: specs/generate-borgmatic-config.spec borgmatic-${VERSION}
	cp specs/generate-borgmatic-config.spec borgmatic-${VERSION}
	( cd borgmatic-${VERSION} ; pyinstaller generate-borgmatic-config.spec )

borgmatic-${VERSION}/dist/upgrade-borgmatic-config: specs/upgrade-borgmatic-config.spec borgmatic-${VERSION}
	cp specs/upgrade-borgmatic-config.spec borgmatic-${VERSION}
	( cd borgmatic-${VERSION} ; pyinstaller upgrade-borgmatic-config.spec )

borgmatic-${VERSION}/dist/validate-borgmatic-config: specs/validate-borgmatic-config.spec borgmatic-${VERSION}
	cp specs/validate-borgmatic-config.spec borgmatic-${VERSION}
	( cd borgmatic-${VERSION} ; pyinstaller validate-borgmatic-config.spec )

# Targets - preparations

borgmatic-${VERSION}:
	pip install borgmatic==${VERSION}
	pip download --no-deps --no-binary :all: borgmatic==${VERSION}
	tar -xf borgmatic-${VERSION}.tar.gz

# Targets - distribution

dist: borgmatic-${VERSION}/dist/borgmatic \
	    borgmatic-${VERSION}/dist/generate-borgmatic-config \
			borgmatic-${VERSION}/dist/upgrade-borgmatic-config \
			borgmatic-${VERSION}/dist/validate-borgmatic-config
	mkdir -p borgmatic-${VERSION}-${ARCH}/bin
	cp README.md borgmatic-${VERSION}-${ARCH}
	cp LICENSE borgmatic-${VERSION}-${ARCH}
	cp borgmatic-${VERSION}/dist/borgmatic borgmatic-${VERSION}-${ARCH}/bin
	cp borgmatic-${VERSION}/dist/generate-borgmatic-config borgmatic-${VERSION}-${ARCH}/bin
	cp borgmatic-${VERSION}/dist/upgrade-borgmatic-config borgmatic-${VERSION}-${ARCH}/bin
	cp borgmatic-${VERSION}/dist/validate-borgmatic-config borgmatic-${VERSION}-${ARCH}/bin
	tar -cvzf borgmatic-${VERSION}-${ARCH}.tar.gz borgmatic-${VERSION}-${ARCH}

# Targets - cleaning up

clean:
	rm -f borgmatic-${VERSION}/dist/*

realclean: clean
	rm -f borgmatic-${VERSION}.tar.gz
	rm -fr borgmatic-${VERSION}
	rm -fr borgmatic-${VERSION}-${ARCH}

distclean: realclean
	rm -f borgmatic-${VERSION}-${ARCH}.tar.gz
