#!/bin/bash
#Copyright (c) 2023-2025 Divested Computing Group
#This program is free software: you can redistribute it and/or modify
#it under the terms of the GNU Affero General Public License as published by
#the Free Software Foundation, either version 3 of the License, or
#(at your option) any later version.
#
#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU Affero General Public License for more details.
#
#You should have received a copy of the GNU Affero General Public License
#along with this program.  If not, see <https://www.gnu.org/licenses/>.

rm -rf output;
cp -r --reflink=auto static output;
mkdir output/pages;

#workaround hmalloc on host
if command -v bwrap &> /dev/null && [ -f /etc/ld.so.preload ]; then
       alias asmpage='bwrap --dev-bind / / --ro-bind /dev/null /etc/ld.so.preload php assemble_pages.php';
else
       alias asmpage='php assemble_pages.php';
fi;

#helper
if command -v firejail &> /dev/null; then
	alias fjnn='firejail --net=none';
else
	alias fjnn='';
fi;

declare -a staticPages=("home" "privacy_policy" "terms_of_service" "search" "screener_aq" "screener_phq-9" "screener_phq-15" "screener_gad-7" "screener_pq-b" "screener_cat-q" "screener_tas" "screener_raads-r" "screener_asrs" "screener_mdq" "screener_asa-27" "screener_bsl-23" "screener_fas" "screener_thi" "screener_acos-self" "screener_eq-40" "screener_wurs-25" "screener_bes" "screener_oci-r" "screener_voci" "screener_des-ii" "screener_mid-60");

for page in "${staticPages[@]}"
do
	asmpage "$page" > "output/pages/$page.html";
done;

#gzip -k output/pages/*.html output/assets/css/*.css output/assets/js/*.js;
#brotli -k output/pages/*.html output/assets/css/*.css output/assets/js/*.js;

ln -sf pages/home.html output/index.html;

if command -v pagefind &> /dev/null; then
	fjnn pagefind --site output/pages;
else
	echo "pagefind is unavailable, not generating search index"
fi;
