TAGS="TODO:|FIXME:"
find "${SRCROOT}/" \( -name "*.xcconfig" \) -print0 | xargs -0 egrep --with-filename --line-number --only-matching "($TAGS).*\$" | perl -p -e "s/($TAGS)/ warning: \$1/"
