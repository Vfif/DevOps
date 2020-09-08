for i in {1..2}
do
  read line
  array[i]=$line
done
for i in {1..3}
do
	echo -n ${array[@]}
  echo -n " "
done