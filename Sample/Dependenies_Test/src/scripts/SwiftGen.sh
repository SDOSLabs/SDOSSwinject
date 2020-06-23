date > ${TEMP_DIR}/swiftgen-lastrun

#Strings
"${PODS_ROOT}/SwiftGen/bin/swiftgen" strings --templateName structured-swift4 "${SRCROOT}/main/resources/generated/es.lproj/" --output "${SRCROOT}/main/resources/generated/Strings.generated.swift"
#Assets
"${PODS_ROOT}/SwiftGen/bin/swiftgen" xcassets --templateName swift4 "${SRCROOT}/main/resources/Assets.xcassets" --output "${SRCROOT}/main/resources/generated/Images.generated.swift"
#Fonts
"${PODS_ROOT}/SwiftGen/bin/swiftgen" fonts -t swift4 "${SRCROOT}/main/resources/fonts" --output "${SRCROOT}/main/resources/generated/Fonts.generated.swift"
