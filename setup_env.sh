# this script sets up development environment

cd packages/rad

cd ../rad
dart pub get
cd ../rad_test
dart pub get

cd ../../example/multi_app_example

cd ../multi_app_example
dart pub get
cd ../routing_example
dart pub get

cd ../../
