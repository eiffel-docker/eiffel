#!/bin/sh                                                                                    
echo "Fix Eiffel runtime, by replacing sys_siglist[sig] by strsignal(sig)"

\rm -rf C
tar xjvf c.tar.bz2
sed "s/sys_siglist\[\(..*\)]/strsignal(\1)/g" C/run-time/sig.c > C/run-time/sig.c.new && mv C/run-time/sig.c.new C/run-time/sig.c
tar cjvf c.tar.bz2 C/*
\rm -rf C

echo Eiffel runtime fixed.
