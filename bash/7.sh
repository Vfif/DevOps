for i in {1..10}
do
  read line
  array[i]=$line
done
echo ${array[@]}