set -x

json_out=`pwd`/errors.json
report_out=`pwd`/report
rm -rf $json_out
rm -rf $report_out

# This file is modified according to .gitlab-ci.yml
apt update -qq
apt install -qq -y eatmydata autoconf autopoint gettext
apt install -qq -y --no-install-recommends git ca-certificates
apt build-dep -qq -y .
apt install -qq -y --no-install-recommends libmodule-build-perl
apt install -qq -y --no-install-recommends \
      fakeroot gpg cppcheck aspell aspell-en i18nspector \
      libtest-strict-perl libtest-minimumversion-perl libtest-perl-critic-perl \
      libtest-pod-perl libtest-pod-coverage-perl libtest-spelling-perl \
      libtest-synopsis-perl

./autogen
./configure CC=kcc LD=kcc CFLAGS="-fissue-report=$json_out" 

make -j`nproc`
# make distcheck
# make check VERBOSE=1 TESTSUITEFLAGS=--verbose TEST_PARALLEL=$(nproc) AUTHOR_TESTING=1
# mkdir -p build-tree
# cd build-tree
# make check VERBOSE=1 TESTSUITEFLAGS=--verbose TEST_PARALLEL=$(nproc)

touch $json_out && rv-html-report $json_out -o $report_out