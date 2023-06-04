# this script run tests

# generate tests

cd packages/rad/test && python3 scripts/main.py gen && cd ../../../
cd packages/rad_html_vscode && python3 test/gen.py

# run all tests

cd ../rad
dart test
cd ../rad_test
dart test
cd ../rad_hooks
dart test
cd ../rad_html_vscode
dart test

cd ../../
