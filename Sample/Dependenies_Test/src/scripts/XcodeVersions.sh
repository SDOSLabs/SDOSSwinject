file="$SRCROOT/xcode-version.lock"

# create file if it does not exist
touch "${file}"

# if file does not exist or it is not readable -> error
if [ ! -r "${file}" ]
then
    echo "error: Could not create file: ${file} (see the Xcode Version script in Build Phases)"
    error -1
fi
# read the keys and values in the file
while IFS='=' read -r key value
do
    eval "${key}='${value}'"
done < "${file}"

# if not defined the keys: XCODE_VERSION_MAJOR_REQUIRED, XCODE_VERSION_MINOR_REQUIRED, XCODE_VERSION_ACTUAL_REQUIRED
if ([ -z ${XCODE_VERSION_MAJOR_REQUIRED:+"1"} ] || [ -z ${XCODE_VERSION_MINOR_REQUIRED:+"1"} ] || [ -z ${XCODE_VERSION_ACTUAL_REQUIRED:+"1"} ])
then
    echo "XCODE_VERSION_MAJOR_REQUIRED=${XCODE_VERSION_MAJOR}" > "${file}"
    echo "XCODE_VERSION_MINOR_REQUIRED=${XCODE_VERSION_MINOR}" >> "${file}"
    echo "XCODE_VERSION_ACTUAL_REQUIRED=${XCODE_VERSION_ACTUAL}" >> "${file}"

    echo "warning: Required Xcode version set to ${XCODE_VERSION_ACTUAL} in this project. If you want to build this project with a different version of Xcode, please remove ${file} file"
elif ([ ${XCODE_VERSION_MAJOR_REQUIRED} != ${XCODE_VERSION_MAJOR} ] || [ ${XCODE_VERSION_MINOR_REQUIRED} != ${XCODE_VERSION_MINOR} ])
then
    echo "error: [SDOS error] - The required version of Xcode to run this project is ${XCODE_VERSION_MINOR_REQUIRED} and the current version of Xcode is ${XCODE_VERSION_MINOR}. If you want to build this project with a different version of Xcode, please remove ${file} file"
    error 0
elif ([ ${XCODE_VERSION_ACTUAL_REQUIRED} != ${XCODE_VERSION_ACTUAL} ])
then
    echo "warning: [SDOS warning] - XCODE VERSION CONFLICT: The required version of Xcode to run this project is ${XCODE_VERSION_ACTUAL_REQUIRED} and the current version of Xcode is ${XCODE_VERSION_ACTUAL}. This might cause some problems at runtime."
fi
