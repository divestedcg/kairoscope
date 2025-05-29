#!/bin/bash
for i in {1..40}
do
	if [ "$i" = 1 ] || [ "$i" = 3 ] || [ "$i" = 11 ] || [ "$i" = 13 ] || [ "$i" = 14 ] || [ "$i" = 15 ] || [ "$i" = 21 ] || [ "$i" = 22 ] || [ "$i" = 23 ] || [ "$i" = 24 ] || [ "$i" = 26 ] || [ "$i" = 27 ] || [ "$i" = 28 ] || [ "$i" = 29 ] || [ "$i" = 34 ] || [ "$i" = 35 ] || [ "$i" = 36 ] || [ "$i" = 37 ] || [ "$i" = 38 ] || [ "$i" = 39 ] || [ "$i" = 40 ]; then
		cat question_template-asc | sed "s/1\. /$i./" | sed "s/q1/q$i/"
	else
		cat question_template-dsc | sed "s/1\. /$i./" | sed "s/q1/q$i/"
	fi;
echo ""
done
