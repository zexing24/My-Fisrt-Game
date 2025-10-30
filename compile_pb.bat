echo off

echo.

echo ��ʼ����.proto�ļ�������.js�ļ�...
echo.
call ./node_modules/.bin/pbjs --dependency protobufjs/minimal.js --keep-case --target static-module --wrap commonjs --out ./assets/scripts/pb/proto.js ./pb/*.proto
echo.


echo ��ʼ����.js�ļ�������.d.ts�ļ�...
echo.
call ./node_modules/.bin/pbts --main --out ./assets/scripts/pb/proto.d.ts ./assets/scripts/pb/*.js
echo.


echo ��ʼ�޸�����.js�ļ�...
echo.
echo ��ʼ�޸�"properties"...
call "./tools/sed" -i "s/if (properties)/if (!properties) properties = Object.getPrototypeOf(this);\n\t\t\tif (properties)/g " ./assets/scripts/pb/proto.js
echo ��ʼ�޸�"$root"...
call "./tools/sed" -i "s/var $root = $protobuf/var $root = ($protobuf.roots['pb_game'] = {})\/\/$protobuf/g" ./assets/scripts/pb/proto.js
echo.
echo �޸����!
echo.
echo.

echo ������ɣ�����
echo.
echo.

pause
