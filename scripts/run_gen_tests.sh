# this script generate tests

# generate tests

cd packages/rad/test && python3 scripts/main.py gen && cd ../../../
cd packages/rad_html_vscode && python3 test/gen.py

cd ../../
