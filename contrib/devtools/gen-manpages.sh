#!/bin/sh

TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
SRCDIR=${SRCDIR:-$TOPDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

BITCOIND=${BITCOIND:-$SRCDIR/mannad}
BITCOINCLI=${BITCOINCLI:-$SRCDIR/manna-cli}
BITCOINTX=${BITCOINTX:-$SRCDIR/manna-tx}
BITCOINQT=${BITCOINQT:-$SRCDIR/qt/manna-qt}

[ ! -x $BITCOIND ] && echo "$BITCOIND not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
MNAVER=($($BITCOINCLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }'))

# Create a footer file with copyright content.
# This gets autodetected fine for mannad if --version-string is not set,
# but has different outcomes for manna-qt and manna-cli.
echo "[COPYRIGHT]" > footer.h2m
$BITCOIND --version | sed -n '1!p' >> footer.h2m

for cmd in $BITCOIND $BITCOINCLI $BITCOINTX $BITCOINQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${MNAVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${MNAVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
