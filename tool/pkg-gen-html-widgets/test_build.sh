#!/bin/sh

analyze() {
    dart pub get
    dart format .
    OUTPUT="$(dart analyze --fatal-infos)"
    
    echo "$OUTPUT"

    if grep -q "error" <<< "$OUTPUT"; then
        echo "dart analyze found errors"
        exit 1
    else
        echo "dart analyze didn't find any errors"
    fi
}

echo "Step: generate with default settings"
python3 gen.py
cd out
analyze
cd ..

echo "Step: generate to tmp"
python3 gen.py --out=tmp
cd tmp
analyze
cd ..

echo "Step: change className type"
python3 gen.py --className:retype=set
cd out
analyze
cd ..
python3 gen.py --className:retype=list
cd out
analyze
cd ..
python3 gen.py --className:retype=string
cd out
analyze
cd ..

echo "Step: change className name"
python3 gen.py --className:rename=classes
cd out
analyze
cd ..

echo "Step: do both"
python3 gen.py --className:rename=classes --className:retype=set
cd out
analyze
cd ..
