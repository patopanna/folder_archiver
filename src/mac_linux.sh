#!/bin/zsh

get_date=$(date +%Y%m%d)
zip_file="MyWorks_${get_date}.zip"
folder_path="/home/$(whoami)/MyWorks"
archive_path="/home/$(whoami)/archive"

# フォルダをzip圧縮して保存
zip -r "${archive_path}/${zip_file}" "$folder_path"

# 新しいzipファイルを3つ残し、それ以外を削除
ls -1t "${archive_path}"/*.zip | tail -n +4 | xargs rm -f