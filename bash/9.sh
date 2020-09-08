for i in {1..10}
do
  read line
  if [[ $line != *[Aa]* ]]
  then
  array[i]=$line
  fi
done
echo ${array[@]}