# this script run tests

cd packages/rad

cd ../rad
dart test
cd ../rad_test
dart test
cd ../rad_hooks
dart test

cd ../../
