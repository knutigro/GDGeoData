#!/bin/sh
set -e

xctool -project GDGeoDataDemo/GDGeoDataDemo.xcodeproj -scheme GDGeoDataDemo build test -sdk iphonesimulator

