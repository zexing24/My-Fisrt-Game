echo off

echo.

echo 开始编译.proto文件，生成.js文件...
echo.
call ./node_modules/.bin/pbjs --dependency protobufjs/minimal.js --keep-case --target static-module --wrap commonjs --out ./assets/scripts/pb/proto.js ./pb/*.proto
echo.


echo 开始编译.js文件，生成.d.ts文件...
echo.
call ./node_modules/.bin/pbts --main --out ./assets/scripts/pb/proto.d.ts ./assets/scripts/pb/*.js
echo.


echo 开始修复生成.js文件...
echo.
echo 开始修复"properties"...
call "./tools/sed" -i "s/if (properties)/if (!properties) properties = Object.getPrototypeOf(this);\n\t\t\tif (properties)/g " ./assets/scripts/pb/proto.js
echo 开始修复"$root"...
call "./tools/sed" -i "s/var $root = $protobuf/var $root = ($protobuf.roots['pb_game'] = {})\/\/$protobuf/g" ./assets/scripts/pb/proto.js
echo.
echo 修复完成!
echo.
echo.

echo 处理完成！！！
echo.
echo.

pause
