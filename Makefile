PREFIX ?= /usr/local

BINPROG = genfstab
MANPAGE = doc/genfstab.8

BASH = bash
ZSHCOMP = completion/zsh/_genfstab
BASHCOMP = completion/bash/genfstab

all: $(BINPROG)

V_GEN = $(_v_GEN_$(V))
_v_GEN_ = $(_v_GEN_0)
_v_GEN_0 = @echo "  GEN     " $@;

edit = $(V_GEN) m4 -P $@.in >$@ && chmod go-w,+x $@

genfstab: genfstab.in fstab-helpers
	$(edit)

man: $(MANPAGE)

doc/%: doc/%.asciidoc doc/asciidoc.conf
	$(V_GEN) a2x --no-xmllint --asciidoc-opts="-f doc/asciidoc.conf" -d manpage -f manpage -D doc $<

clean:
	$(RM) $(BINPROG)

check: $(BINPROG)
	bash -O extglob -n $(BINPROG)
	@r=0; for t in test/test_*; do $(BASH) $$t || { echo $$t fail; r=1; }; done; exit $$r

shellcheck: $(BINPROG)
	shellcheck -W 99 --color $(BINPROG)
	shellcheck -W 99 --color -x test/test_*

install: all
	install -d $(DESTDIR)$(PREFIX)/bin
	install -m 0755 $(BINPROG) $(DESTDIR)$(PREFIX)/bin
	install -d $(DESTDIR)$(PREFIX)/share/zsh/site-functions
	install -m 0644 $(ZSHCOMP) $(DESTDIR)$(PREFIX)/share/zsh/site-functions
	install -d $(DESTDIR)$(PREFIX)/share/bash-completion/completions
	install -m 0644 $(BASHCOMP) $(DESTDIR)$(PREFIX)/share/bash-completion/completions
	if [ -f $(MANPAGE) ]; then \
		install -d $(DESTDIR)$(PREFIX)/share/man/man8 && \
		install -m 0644 $(MANPAGE) $(DESTDIR)$(PREFIX)/share/man/man8; \
	fi

.PHONY: all man clean check shellcheck install
