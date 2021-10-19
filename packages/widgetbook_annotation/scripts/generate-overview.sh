# Running this file requires lcov
# install lcov like this
# MacOS: `brew install lcov`
flutter test --coverage
lcov --remove coverage/lcov.info 'lib/constants/*' -o coverage/lcov.info
# lcov --remove coverage/lcov.info 'lib/models/*' -o coverage/lcov.info
genhtml coverage/lcov.info -o coverage/html