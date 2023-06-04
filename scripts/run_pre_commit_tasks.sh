# this script run pre commit tasks

cd packages/rad

cd ../rad
dart run build_runner build
dart pub run import_sorter:main
dart format $(find . -name "*.dart" -not -path "*/templates/*" -not -path '*/.*')

cd ../rad_test
dart pub run import_sorter:main
dart format $(find . -name "*.dart" -not -path "*/templates/*" -not -path '*/.*')

cd ../rad_hooks
dart pub run import_sorter:main
dart format $(find . -name "*.dart" -not -path "*/templates/*" -not -path '*/.*')

cd ../rad_html_vscode
dart pub run import_sorter:main
dart format $(find . -name "*.dart" -not -path "*/templates/*" -not -path '*/.*')

cd ../../
