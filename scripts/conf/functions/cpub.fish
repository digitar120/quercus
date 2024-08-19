function cpub --wraps='w3m -dump cpubenchmark.net/cpu_list.php | grep ' --description 'alias cpub=w3m -dump cpubenchmark.net/cpu_list.php | grep '
  w3m -dump cpubenchmark.net/cpu_list.php | grep  $argv
        
end
