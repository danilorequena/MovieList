#!/bin/bash
set -e
xcodebuild -project 'CinemaTv.xcodeproj' -scheme 'CinemaTv' -destination 'generic/platform=iOS Simulator,name=iPhone 12' -configuration Release build CODE_SIGNING_ALLOWED=NO
