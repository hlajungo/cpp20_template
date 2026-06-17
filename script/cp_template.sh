#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 new_name"
  exit 1
fi
new_name=$1

cp -r template ${new_name}

# 替換子目錄 CMakeLists.txt 中的名稱
sed -i "s/set(SUBPROJECT_NAME template)/set(SUBPROJECT_NAME ${new_name})/g" \
  ${new_name}/CMakeLists.txt

# 根目錄 CMakeLists.txt 增加 option
sed -i "/option(TEST_VERBOSE \"Enable test verbose.\" OFF)/a option(BUILD_${new_name} \"Build ${new_name}.\" ON)" CMakeLists.txt

# 在根目錄 CMakeLists.txt 最後增加子目錄掛載邏輯
cat <<EOF >> CMakeLists.txt

if(BUILD_${new_name})
  message(STATUS "${new_name} enable.")
  add_subdirectory(${new_name})
endif()
EOF

echo "Subproject ${new_name} create."
