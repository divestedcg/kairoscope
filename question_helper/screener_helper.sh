#!/bin/bash
for i in {1..60}
do
cat question_template | sed "s/1\. /$i./" | sed "s/q1/q$i/"
echo ""
done
